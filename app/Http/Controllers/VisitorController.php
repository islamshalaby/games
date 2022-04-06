<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use App\Helpers\APIHelpers;
use App\Visitor;
use App\Cart;
use App\Favorite;
use App\Product;
use App\ProductImage;
use App\ProductMultiOption;
use App\SizeDetail;
use App\Shop;
use App\UserAddress;
use App\DeliveryArea;
use App\Setting;
use App\Address;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class VisitorController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api' , ['except' => ['create' , 'add' , 'delete' , 'get' , 'changecount' , 'getcartcount']]);
    }

    // create visitor 
    public function create(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            // 'fcm_token' => "required",
            'type' => 'required' // 1 -> iphone ---- 2 -> android
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $last_visitor = Visitor::where('unique_id' , $request->unique_id)->first();
		
        if($last_visitor){
            if ($request->fcm_token && !empty($request->fcm_token)) {
                $last_visitor->fcm_token = $request->fcm_token;
            }
            $last_visitor->save();
            $visitor = $last_visitor;
        }else{
            $visitor = new Visitor();
            $visitor->unique_id = $request->unique_id;
            if ($request->fcm_token && !empty($request->fcm_token)) {
                $visitor->fcm_token = $request->fcm_token;
            }
            $visitor->type = $request->type;
            $visitor->save();
        }


        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $visitor , $request->lang);
        return response()->json($response , 200);
    }

    // add to cart
    public function add(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            'product_id' => 'required|exists:products,id'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields or product does not exist' , 'بعض الحقول مفقودة او المنتج غير موجود' , null , $request->lang);
            return response()->json($response , 406);
        }

        $product = Product::find($request->product_id);
        

        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        if($visitor){
            
            $cart = Cart::where('visitor_id' , $visitor->id)->where('product_id' , $request->product_id)->first();
            if($product->remaining_quantity < 1){
                $response = APIHelpers::createApiResponse(true , 406 , 'The remaining amount of the product is not enough' , 'الكميه المتبقيه من المنتج غير كافيه'  , null , $request->lang);
                return response()->json($response , 406);
            }
           
            
            if($cart){
                $count = $cart->count;
                $cart->count = $count + 1;
                $cart->save();
            }else{
                $cart = new Cart();
                $cart->count = 1;
                $cart->product_id = $request->product_id;
                $cart->visitor_id = $visitor->id;
                $cart->store_id = $product->store_id;
                $cart->save();
            }
            

            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $cart , $request->lang);
            return response()->json($response , 200);

        }else{
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }

    }

    // remove from cart
    public function delete(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            'product_id' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        if($visitor){
            
            $cart = Cart::where('product_id' , $request->product_id)->where('visitor_id' , $visitor->id)->first();
            
            $cart->delete();

            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , null , $request->lang);
            return response()->json($response , 200);

        }else{
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
    }

    // get cart
    public function get(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        $selectedAddress = Address::where('visitor_id', $visitor['id'])->first();
        // dd($selectedAddress);
        if($visitor){
            $visitor_id =  $visitor['id'];
            $cart = Cart::where('visitor_id' , $visitor_id)->select('id' , 'count', 'product_id')->get()->toArray();
            $data['subtotal_price'] = "0";
            for($i = 0; $i < count($cart); $i++){
                $cartProduct = Product::where('id', $cart[$i]['product_id'])->select("store_id")->first();
                $deliveryA = DeliveryArea::where('area_id', $selectedAddress['address_id'])->where('store_id', $cartProduct->store_id)->whereHas('store', function($q) {
                    $q->where('status', 1);
                })->first();
                
                if ($deliveryA == null) {
                    $itm = Cart::where('id', $cart[$i]['id'])->select('id')->first();
                    $itm->delete();
                    array_splice($cart, $i, 1);
                    break;
                }else {
                    $cart[$i]['id'] = $cart[$i]['product_id'];
                    if($request->lang == 'en'){
                        $product = Product::with('store')->select('title_en as title' , 'final_price' , 'price_before_offer', 'id', 'store_id', 'offer_percentage', 'offer')->where('id', $cart[$i]['id'])->first();
                    }else{
                        $product = Product::with('store')->select('title_ar as title' , 'final_price' , 'price_before_offer', 'id', 'store_id', 'offer_percentage', 'offer')->where('id', $cart[$i]['id'])->first();
                    }
                    
                    if(auth()->user()){
                        $user_id = auth()->user()->id;
                        $prevfavorite = Favorite::where('product_id' , $cart[$i]['id'])->where('user_id' , $user_id)->first();
                        if($prevfavorite){
                            $cart[$i]['favorite'] = true;
                        }else{
                            $cart[$i]['favorite'] = false;
                        }
        
                    }else{
                        $cart[$i]['favorite'] = false;
                    }
    
                    $cart[$i]['final_price'] = number_format((float)$product['final_price'], 3, '.', '');
                    $cart[$i]['price_before_offer'] = number_format((float)$product['price_before_offer'], 3, '.', '');
                    $cart[$i]['offer_percentage'] = $product['offer_percentage'];
                    $cart[$i]['offer'] = $product['offer'];
                    $sBPrice = $data['subtotal_price'] + ($product['final_price'] * $cart[$i]['count']);
                    $data['subtotal_price'] = number_format((float)$sBPrice, 3, '.', '');
                    
                    $cart[$i]['title'] = $product['title'];
                    $cart[$i]['type'] = $product['type'];
                    $cart[$i]['store_name'] = $product->store->name;
                    $cart[$i]['store_id'] = $product->store->id;
                    $cart[$i]['image'] = ProductImage::select('image')->where('product_id' , $cart[$i]['id'])->first()['image'];
                }
                
            }
            
            $data['cart'] = $cart;
            $data['count'] = count($cart);
            
            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
            return response()->json($response , 200);

        }else{
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
        

    }

    // get cart count 
    public function getcartcount(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        if($visitor){
            $visitor_id =  $visitor['id'];
            $cart = Cart::where('visitor_id' , $visitor_id)->select('product_id as id' , 'count')->get();
            $count['count'] = count($cart);

            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $count , $request->lang);
            return response()->json($response , 200);

        }else{
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
    }

    // change count
    public function changecount(Request $request){
 
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            'product_id' => 'required|exists:products,id',
            'new_count' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields or product does not exist' , 'بعض الحقول مفقودة او المنتج غير موجود'  , null , $request->lang);
            return response()->json($response , 406);
        }

        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        
        $product = Product::find($request->product_id);
        if($product->remaining_quantity < $request->new_count){
            $response = APIHelpers::createApiResponse(true , 406 , 'The remaining amount of the product is not enough' , 'الكميه المتبقيه من المنتج غير كافيه'  , null , $request->lang);
            return response()->json($response , 406);
        }
        
        

        if($visitor){
            
            $cart = Cart::where('product_id' , $request->product_id)->where('visitor_id' , $visitor->id)->first()->makeHidden('option_id');
            
            
            if (isset($cart->count)) {
                $cart->count = $request->new_count;
                $cart->save();
                $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $cart , $request->lang);
                return response()->json($response , 200);
            }else {
                $response = APIHelpers::createApiResponse(true , 406 , 'This product is not exist in cart' , 'هذا المنتج غير موجود بالعربة' , null , $request->lang);
                return response()->json($response , 406);
            }
        }else{
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
        
    }

    // get cart before order
    public function get_cart_before_order(Request $request) {
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            'address_id' => 'required'
        ]);
        

        // dd(auth()->user()->id);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }
        
        $address = UserAddress::find($request->address_id)->makeHidden(['created_at', 'updated_at']);
        
        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        $selectedAddress = Address::where('visitor_id', $visitor['id'])->first();

        if($visitor){
            $visitor_id =  $visitor['id'];
            $cart = Cart::where('visitor_id' , $visitor_id)->select('id', 'product_id' , 'count', 'option_id')->get();
			//dd($visitor_id);
            
            $stores = [];
            for($i = 0; $i < count($cart); $i++){
				$deliveryA = DeliveryArea::where('area_id', $address['area_id'])->where('store_id', $cart[$i]->product->store_id)->first();
                if ($deliveryA == null) {
                    $cart[$i]->delete();
                }else {
					array_push($stores, $cart[$i]->product->store_id);
				}
                
            }
            $data['address'] = $address;
            $data['shipments'] = [];
            $get_stores = Shop::select('name', 'id')->whereIn('id', $stores)->get();
            $data['subtotal_price'] = "0";
            $data['delivery_cost'] = "0";
            //dd($get_stores);
            for ($i = 0; $i < count($get_stores); $i ++) {
                
                $data['shipments'][$i]['shipment_number'] = $i + 1;
                $store = Shop::where('id', $get_stores[$i]['id'])->select('id', 'name', 'logo')->first()->makeHidden('custom');
                $delivery_cost = DeliveryArea::select('delivery_cost', 'estimated_arrival_time')->where('area_id', $address['area_id'])->where('store_id', $get_stores[$i]['id'])->first();
                $d_cost = $data['delivery_cost'] + $delivery_cost['delivery_cost'];
                $data['delivery_cost'] = number_format((float)$d_cost, 3, '.', '');
                $store['estimated_arrival_time'] = $delivery_cost['estimated_arrival_time'];
                $store['delivery_cost'] = number_format((float)$delivery_cost['delivery_cost'], 3, '.', '');
                $data['shipments'][$i]['store'] = $store;
                $products = [];
                $data['shipments'][$i]['store']['total_price'] = $delivery_cost['delivery_cost'];
                
                for ($n = 0; $n < count($cart); $n ++) {
                    if ($request->lang == 'en') {
                        $product = Product::select('title_en as title', 'final_price', 'price_before_offer', 'offer_percentage', 'id', 'offer', 'store_id')->where('id', $cart[$n]['product_id'])->first()->makeHidden('mainImage');
                    }else {
                        $product = Product::select('title_en as title', 'final_price', 'price_before_offer', 'offer_percentage', 'id', 'offer', 'store_id')->where('id', $cart[$n]['product_id'])->first()->makeHidden('mainImage');
                    }
                    $product['final_price'] = number_format((float)$product['final_price'], 3, '.', '');
                    // $product['count'] = $cart[$n]['count'];
                    $product['price_before_offer'] = number_format((float)$product['price_before_offer'], 3, '.', '');
                    if ($get_stores[$i]['id'] == $product['store_id']) {
                        $product['store_name'] = $store['name'];
                        if (isset($product->mainImage['image'])) {
                            $product['main_image'] = $product->mainImage['image'];
                        }else if(count($product->images) > 0) {
                            $product['main_image'] = $product->images[0]['image'];
                        }else {
                            $product['main_image'] = '';
                        }
                        $sTPrice = $product['final_price'] + $data['shipments'][$i]['store']['total_price'];
                        $data['shipments'][$i]['store']['total_price'] = number_format((float)$sTPrice, 3, '.', '');
                        $subTPrice = $data['subtotal_price'] + ($product['final_price'] * $cart[$n]['count']);
                        $data['subtotal_price'] = number_format((float)$subTPrice, 3, '.', '');

                    
                        array_push($products, $product);
                    }
                    
                }
                
                $data['shipments'][$i]['store']['products'] = $products;
            }
            $tPrice = $data['subtotal_price'] + $data['delivery_cost'];
            $data['total_price'] = number_format((float)$tPrice, 3, '.', '');

            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
            return response()->json($response , 200);

        }else{
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
    }
 

}