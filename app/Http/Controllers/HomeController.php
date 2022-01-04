<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Helpers\APIHelpers;
use App\HomeElement;
use App\Category;
use App\Favorite;;
use App\Product;
use App\ProductImage;
use App\ProductMultiOption;
use App\Area;
use App\Address;
use App\Visitor;
use App\DeliveryArea;
use App\Ad;
use App\Slider;
use App\Shop;
use App\Cart;


class HomeController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api' , ['except' => ['getdata']]);
    }

    public function getdata(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            // 'place_id' => 'required',
            'area_id' => 'required',
            'category_id' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة'  , null , $request->lang);
            return response()->json($response , 406);
        }
        
        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        $current_area = Area::where('id', $request->area_id)->first();
        
        if (isset($visitor['id'])) {
            $address = Address::where('visitor_id', $visitor['id'])->first();
            if (isset($current_area['id']) && isset($address['id'])) {
                $address->update(['address_id' => $current_area['id']]);
            }else if(isset($current_area['id'])) {
                Address::create(['visitor_id' => $visitor['id'], 'address_id' => $current_area['id']]);
            }else {
                $response = APIHelpers::createApiResponse(true , 406 , 'Area is not found' , 'المنطقة غير موجودة'  , null , $request->lang);
                return response()->json($response , 406);
            }
            $stores = DeliveryArea::where('area_id', $current_area['id'])->whereHas('store', function($q) {
                $q->where('status', 1)->where('show_home', 1);
            })->pluck('store_id')->toArray();
            $slider = Slider::where('type', 1)->first();
            $data['slider'] = $slider->ads->toArray();
    
            if (count($data['slider']) > 0) {
                for ($s = 0; $s < count($data['slider']); $s ++) {
                    if ($data['slider'][$s]['type'] == 1 && $data['slider'][$s]['content_type'] == 1) {
                        $prod = Product::where('id', $data['slider'][$s]['content'])->whereHas('store', function($q) use ($stores) {
                            $q->whereIn('store_id', $stores)->where('status', 1);
                        })->select('title_' . $request->lang . ' as title')->first();
                        if ($prod) {
                            $data['slider'][$s]['content_name'] = $prod->title;
                        }else {
                            array_splice($data['slider'], $s, 1);
                        }
                    }elseif ($data['slider'][$s]['type'] == 1 && $data['slider'][$s]['content_type'] == 2) {
                        $cat = Category::where('id', $data['slider'][$s]['content'])->whereHas('products', function($q) use($stores) {
                            $q->whereIn('store_id', $stores)->whereHas('store', function($qu) {
                                $qu->where('status', 1);
                            });
                        })->select('title_' . $request->lang . ' as title')->first();
                        if ($cat) {
                            $data['slider'][$s]['content_name'] = $cat->title;
                        }else {
                            array_splice($data['slider'], $s, 1);
                        }
                    }elseif ($data['slider'][$s]['type'] == 1 && $data['slider'][$s]['content_type'] == 3){
                        $shop = Shop::where('id', $data['slider'][$s]['content'])->where('status', 1)->whereIn('id', $stores)->select('name')->first();
                        if ($shop) {
                            $data['slider'][$s]['content_name'] = $shop->name;
                        }else {
                            array_splice($data['slider'], $s, 1); 
                        }
                    }
                }
            }
            
            // dd($stores);
            if ($request->lang == 'en') {
                $data['area'] = $current_area['title_en'];
                $cats = Category::where('deleted', 0)->whereHas('products', function($q) use($stores) {
                    $q->whereIn('store_id', $stores);
                })->select('title_en as title', 'id', 'image')->get();
                $cat = (object)[
                    "id" => 0,
                    "title" => "All",
                    "image" => "all_liwbsi_nkti8l.png",
                    "selected" => false
                ];
                
            }else {
                $data['area'] = $current_area['title_ar'];
                $cats = Category::where('deleted', 0)->whereHas('products', function($q) use($stores) {
                    $q->whereIn('store_id', $stores);
                })->select('title_ar as title', 'id', 'image')->get();
                $cat = (object)[
                    "id" => 0,
                    "title" => "الكل",
                    "image" => "all_liwbsi_nkti8l.png",
                    "selected" => false
                ];
                
            }
            $data['categories'] = [$cat];
            if (count($data['categories']) > 0) {
                for ($p = 0; $p < count($cats); $p ++) {
                    array_push($data['categories'], $cats[$p]);
                }
            }
            
            
            if ($request->category_id == 0) {
                $data['stores'] = Shop::whereIn('id', $stores)->has('products', '>', 0)->select('id', 'logo', 'name', 'min_order_cost')->get()->makeHidden('custom');
                
                if (count($data['stores']) > 0) {
                    for ($i = 0; $i < count($data['stores']); $i ++) {
						$data['stores'][$i]['isAd'] = false;
						$data['stores'][$i]['image'] = "";
						$data['stores'][$i]['type'] = 0;
						$data['stores'][$i]['content'] = "";
						$data['stores'][$i]['content_type'] = 0;
						$data['stores'][$i]['store_id'] = 0;
						$productCategories = Product::where('deleted', 0)->where('hidden', 0)->where('store_id', $data['stores'][$i]['id'])->pluck('category_id')->toArray();
                        if ($request->lang == 'en') {
                            $cats = Category::where('deleted', 0)->whereIn('id', $productCategories)
                            ->select('categories.id', 'categories.title_en as title', 'categories.image')
                            ->get()->makeHidden('custom');
                            // dd($cats);
                        }else {
                            $cats = Category::where('deleted', 0)->whereIn('id', $productCategories)
                            ->select('id', 'title_ar as title', 'image')
                            ->get()->makeHidden('custom');
                        }
                        $storeCats = [];
                        $data['stores'][$i]['categories'] = [];
                        if (count($cats) > 0) {
                            for ($u = 0; $u < count($cats); $u ++) {
                                if ($u <= 1) {
                                    array_push($storeCats, $cats[$u]);
                                }
                            }
                        }
                            
                        // dd($storeCats);
                        $data['stores'][$i]['categories'] = $storeCats;
                        $deliveryArea = DeliveryArea::where('store_id', $data['stores'][$i]['id'])->where('area_id', $current_area['id'])->select('min_order_cost', 'estimated_arrival_time', 'delivery_cost')->first();
                        $data['stores'][$i]['min_order_cost'] = number_format((float)$data['stores'][$i]['min_order_cost'], 3, '.', '');
                        $data['stores'][$i]['estimated_arrival_time'] = $deliveryArea['estimated_arrival_time'];
                        $data['stores'][$i]['delivery_cost'] = number_format((float)$deliveryArea['delivery_cost'], 3, '.', '');
                    }
                }
            }else {
                $data['stores'] = Shop::join('products', 'products.store_id', '=', 'shops.id')
                ->whereIn('shops.id', $stores)
                ->where('products.deleted', 0)
                ->where('products.hidden', 0)
                ->where('categories.id', $request->category_id)
                ->leftjoin('categories', function($join) {
                    $join->on('categories.id', '=', 'products.category_id');
                })
                ->select('shops.id', 'shops.name', 'shops.logo', 'shops.min_order_cost')
                ->groupBy('shops.name')
                ->groupBy('shops.id')
                ->groupBy('shops.logo')
                ->groupBy('shops.min_order_cost')
                ->inRandomOrder()
                ->get()->makeHidden('custom');
                
                if (count($data['stores']) > 0) {
                    for ($i = 0; $i < count($data['stores']); $i ++) {
						$data['stores'][$i]['isAd'] = false;
						$data['stores'][$i]['image'] = "";
						$data['stores'][$i]['type'] = 0;
						$data['stores'][$i]['content'] = "";
						$data['stores'][$i]['content_type'] = 0;
						$data['stores'][$i]['store_id'] = 0;
                        if ($request->lang == 'en') {
                            $data['stores'][$i]['categories'] = Shop::join('products', 'products.store_id', '=', 'shops.id')
                            ->where('products.deleted', 0)
                            ->where('products.hidden', 0)
                            ->where('categories.deleted', 0)
                            ->leftjoin('categories', function($join) {
                                $join->on('categories.id', '=', 'products.category_id');
                            })
                            ->select('categories.id', 'categories.title_en as title', 'categories.image')
                            ->groupBy('categories.id')
                            ->groupBy('categories.title_en')
                            ->groupBy('categories.image')
                            ->get()->makeHidden('custom');
                        }else {
                            $data['stores'][$i]['categories'] = Shop::join('products', 'products.store_id', '=', 'shops.id')
                            ->where('products.deleted', 0)
                            ->where('products.hidden', 0)
                            ->where('categories.deleted', 0)
                            ->leftjoin('categories', function($join) {
                                $join->on('categories.id', '=', 'products.category_id');
                            })
                            ->select('categories.id', 'categories.title_ar as title', 'categories.image')
                            ->groupBy('categories.id')
                            ->groupBy('categories.title_ar')
                            ->groupBy('categories.image')
                            ->get()->makeHidden('custom');
                        }
                        $deliveryArea = DeliveryArea::where('store_id', $data['stores'][$i]['id'])->where('area_id', $current_area['id'])->select('min_order_cost', 'estimated_arrival_time', 'delivery_cost')->first();
                        $data['stores'][$i]['min_order_cost'] = number_format((float)$data['stores'][$i]['min_order_cost'], 3, '.', '');
                        $data['stores'][$i]['estimated_arrival_time'] = $deliveryArea['estimated_arrival_time'];
                        $data['stores'][$i]['delivery_cost'] = number_format((float)$deliveryArea['delivery_cost'], 3, '.', '');
                    }
                }
            }
            for ($n = 0; $n < count($data['categories']); $n ++) {
                // if ($n != 0) {
                    $data['categories'][$n]->selected = false;
                    if ($data['categories'][$n]->id == $request->category_id) {
                        $data['categories'][$n]->selected = true;
                    }
                // }
                
            }

            $new_products = [];
            if (count($data['stores']) > 0) {
                for($i =0; $i < count($data['stores']); $i++){
                    array_push($new_products , $data['stores'][$i]);
                    if(count($data['stores']) > $i+1 ){
                        if ((($i+1) % 3) == 0) {
                            $ad = Ad::select('id', 'image', 'type', 'content', 'content_type', 'store_id')->where('place', 2)->inRandomOrder()->first();
                            
                            if($ad){
                                $ad->logo = "";
                                $ad->name = "";
                                $ad->categories = [];
                                $ad->min_order_cost = "";
                                $ad->estimated_arrival_time = "";
                                $ad->delivery_cost = "";
                                $ad->isAd = true;
                                array_push($new_products , $ad);
                            }
                        
                        }
                    }
                }
                $data['stores'] = $new_products;
            }
            
            
            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
            return response()->json($response , 200);
        }else {
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
        
        
    }

    public function getoffers(Request $request){
		$id = $request->id;
		$ids = HomeElement::where('home_id' , $id)->pluck('element_id');
		        if($request->lang == 'en'){
                    $element['data'] = Product::select('id', 'title_en as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->whereIn('id' , $ids)->get();
                }else{
                    $element['data'] = Product::select('id', 'title_ar as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id')->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->whereIn('id' , $ids)->get();
                }
                
                for($j = 0; $j < count($element['data']) ; $j++){
                    // $element['data'][$j]['favorite'] = false;

                    if(auth()->user()){
                        $user_id = auth()->user()->id;

                        $prevfavorite = Favorite::where('product_id' , $element['data'][$j]['id'])->where('user_id' , $user_id)->first();
                        if($prevfavorite){
                            $element['data'][$j]['favorite'] = true;
                        }else{
                            $element['data'][$j]['favorite'] = false;
                        }

                    }else{
                        $element['data'][$j]['favorite'] = false;
                    }

                    if($request->lang == 'en'){
                        $element['data'][$j]['category_name'] = Category::where('id' , $element['data'][$j]['category_id'])->pluck('title_en as title')->first();
                    }else{
                        $element['data'][$j]['category_name'] = Category::where('id' , $element['data'][$j]['category_id'])->pluck('title_ar as title')->first();
                    }
                    

                    $element['data'][$j]['image'] = ProductImage::where('product_id' , $element['data'][$j]['id'])->pluck('image')->first();
                }
		
				        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $element['data'] , $request->lang);
        return response()->json($response , 200);
		
		
    }

    

}
