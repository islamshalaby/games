<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Helpers\APIHelpers;
use App\Product;
use App\Category;
use App\Brand;
use App\SubCategory;
use App\ProductImage;
use App\Option;
use App\ProductOption;
use App\Favorite;
use App\ProductMultiOption;
use App\PropertiesCategory;
use App\Shop;
use App\Visitor;
use App\Address;
use App\DeliveryArea;
use App\ProductType;

class ProductController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api' , ['except' => ['getdetails' , 'getproducts' , 'getbrandproducts', 'get_sub_category_products', 'getStoreProducts']]);
    }


    public function getdetails(Request $request, $id){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }
        $options = [];
        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        
        $address = Address::where('visitor_id', $visitor['id'])->first();
        $areaStores = DeliveryArea::where('area_id', $address['address_id'])->pluck('store_id')->toArray();
		

        if ($request->lang == 'en') {
            $data['product'] = Product::where('id', $id)
            ->select('id', 'title_en as title', 'description_en as description', 'offer', 'final_price', 'price_before_offer', 'offer_percentage', 'remaining_quantity', 'store_id', 'category_id', 'type')
            ->first();
            if ($data['product']) {
                $data['product'] = $data['product']->makeHidden(['store_id', 'store', 'productProperties', 'category_id', 'type']);
            }
            if (! in_array($data['product']['store_id'], $areaStores)) {
                $response = APIHelpers::createApiResponse(true , 406 , 'This store is not cover your area' , 'هذا المتجر لا يغطى منطقتك' , null , $request->lang);
                return response()->json($response , 406);
            }
            $data['product']['final_price'] = number_format((float)$data['product']['final_price'], 3, '.', '');
            $data['product']['price_before_offer'] = number_format((float)$data['product']['price_before_offer'], 3, '.', '');

            for ($i = 0; $i < count($data['product']->productProperties); $i ++) {
                $single = [
                    'option' => $data['product']->productProperties[$i]->property['title_en'],
                    'value' => $data['product']->productProperties[$i]->values['value_en']
                ];
                array_push($options, $single);
            }
            $data['product']['options'] = $options;
            $data['related_products'] = Product::where('deleted', 0)
            ->where('hidden', 0)
            ->where('reviewed', 1)
            ->where('remaining_quantity', '>', 0)
            ->where('id', '!=', $data['product']['id'])
            ->where('category_id', $data['product']['category_id'])
			->whereIn('store_id', $areaStores)
            ->whereHas('store', function($q) {
                $q->where('status', 1);
            })
            ->select('id', 'title_en as title', 'final_price', 'price_before_offer', 'offer_percentage')
            ->orderBy('id', 'desc')
			->inRandomOrder()->limit(5)
            ->get()->makeHidden('mainImage');
        }else {
            $data['product'] = Product::where('id', $id)
			->whereIn('store_id', $areaStores)
            ->select('id', 'title_ar as title', 'description_ar as description', 'offer', 'final_price', 'price_before_offer', 'offer_percentage', 'remaining_quantity', 'store_id', 'category_id', 'type')
            ->first();
            if ($data['product']) {
                $data['product'] = $data['product']->makeHidden(['store_id', 'store', 'productProperties', 'category_id', 'type']);
            }
            

            if (! in_array($data['product']['store_id'], $areaStores)) {
                $response = APIHelpers::createApiResponse(true , 406 , 'This store is not cover your area' , 'هذا المتجر لا يغطى منطقتك' , null , $request->lang);
                return response()->json($response , 406);
            }

            for ($i = 0; $i < count($data['product']->productProperties); $i ++) {
                $single = [
                    'option' => $data['product']->productProperties[$i]->property['title_en'],
                    'value' => $data['product']->productProperties[$i]->values['value_en']
                ];
                array_push($options, $single);
            }
            $data['product']['options'] = $options;
            $data['related_products'] = Product::where('deleted', 0)
            ->where('hidden', 0)
            ->where('reviewed', 1)
            ->where('remaining_quantity', '>', 0)
            ->where('id', '!=', $data['product']['id'])
            ->where('category_id', $data['product']['category_id'])
            ->whereIn('store_id', $areaStores)
            ->whereHas('store', function($q) {
                $q->where('status', 1);
            })
            ->select('id', 'title_ar as title', 'final_price', 'price_before_offer', 'offer_percentage')
            ->orderBy('id', 'desc')
			->inRandomOrder()->limit(5)
            ->get()->makeHidden('mainImage');
        }

        if(auth()->user()){
            $user_id = auth()->user()->id;

            $prevfavorite = Favorite::where('product_id' , $data['product']['id'])->where('user_id' , $user_id)->first();
            if($prevfavorite){
                $data['product']['favorite'] = true;
            }else{
                $data['product']['favorite'] = false;
            }

        }else{
            $data['product']['favorite'] = false;
        }

        for ($k = 0; $k < count($data['product']->images); $k ++) {
            $data['product']['images'][$k] = $data['product']->images[$k]['image'];
        }

        for ($r = 0; $r < count($data['related_products']); $r ++) {
            if(auth()->user()){
                $user_id = auth()->user()->id;
    
                $prevfavorite = Favorite::where('product_id' , $data['related_products'][$r]['id'])->where('user_id' , $user_id)->first();
                if($prevfavorite){
                    $data['related_products'][$r]['favorite'] = true;
                }else{
                    $data['related_products'][$r]['favorite'] = false;
                }
    
            }else{
                $data['related_products'][$r]['favorite'] = false;
            }
            if ($data['related_products'][$r]->mainImage) {
                $data['related_products'][$r]['image'] = $data['related_products'][$r]->mainImage['image'];
            }else {
                $data['related_products'][$r]['image'] = "";
            }
            $data['related_products'][$r]['final_price'] = number_format((float)$data['related_products'][$r]['final_price'], 3, '.', '');
            $data['related_products'][$r]['price_before_offer'] = number_format((float)$data['related_products'][$r]['price_before_offer'], 3, '.', '');
            
        }

        $data['store'] = $data['product']->store->name;

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    public function getproducts(Request $request){
        $validator = Validator::make($request->all(), [
            'category_id' => 'required',
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $category_id = $request->category_id;
        $sub_category_id = $request->sub_category_id;

        // if($request->lang == 'en'){
        //     $categories = Category::where('deleted' , 0)->select('id' , 'title_en as title' , 'image')->get();   
        // }else{
        //     $categories = Category::where('deleted' , 0)->select('id' , 'title_ar as title' , 'image')->get();   
        // }

        // for($i = 0; $i < count($categories); $i++){
            // if($categories[$i]['id'] == $request->category_id){
            //     $categories[$i]['selected'] = 1;
                if($request->lang == 'en'){
                    $subcategories = SubCategory::where('deleted' , 0)->where('category_id' , $request->category_id)->select('id' , 'title_en as title')->get()->toArray();
                    $all_element = array();
                    $all_element['id'] = 0;
                    $all_element['title'] = 'All';
                    array_unshift($subcategories , $all_element);
                }else{
                    $subcategories = SubCategory::where('deleted' , 0)->where('category_id' , $request->category_id)->select('id' , 'title_en as title')->get()->toArray();
                    $all_element = array();
                    $all_element['id'] = 0;
                    $all_element['title']  = 'الكل';
                    array_unshift($subcategories , $all_element);
                }

                for($j =0; $j < count($subcategories); $j++){
                    if($subcategories[$j]['id'] == $request->sub_category_id){
                        $subcategories[$j]['selected'] = 1;
                    }else{
                        $subcategories[$j]['selected'] = 0;
                    }

                }

                // $categories[$i]['subcategories'] = $subcategories;
                
            // }else{
            //     $categories[$i]['selected'] = 0;
            // }
        // }

        $data['sub_categories'] = $subcategories;

        if($request->sub_category_id == 0){
            if($request->lang == 'en'){
                $products = Product::select('id', 'title_en as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->where('reviewed', 1)->where('category_id' , $request->category_id)->simplePaginate(16);
            }else{
                $products = Product::select('id', 'title_ar as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->where('reviewed', 1)->where('category_id' , $request->category_id)->simplePaginate(16);
            }
        }else{
            if($request->lang == 'en'){
                $products = Product::select('id', 'title_en as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->where('reviewed', 1)->where('category_id' , $request->category_id)->where('sub_category_id' , $request->sub_category_id)->simplePaginate(16);
            }else{
                $products = Product::select('id', 'title_ar as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->where('reviewed', 1)->where('category_id' , $request->category_id)->where('sub_category_id' , $request->sub_category_id)->simplePaginate(16);
            }
        }

        for($i = 0; $i < count($products); $i++){
            
            if(auth()->user()){
                $user_id = auth()->user()->id;

                $prevfavorite = Favorite::where('product_id' , $products[$i]['id'])->where('user_id' , $user_id)->first();
                if($prevfavorite){
                    $products[$i]['favorite'] = true;
                }else{
                    $products[$i]['favorite'] = false;
                }

            }else{
                $products[$i]['favorite'] = false;
            }

            if($request->lang == 'en'){
                $products[$i]['category_name'] = Category::where('id' , $products[$i]['category_id'])->pluck('title_en as title')->first();
            }else{
                $products[$i]['category_name'] = Category::where('id' , $products[$i]['category_id'])->pluck('title_ar as title')->first();
            }
            
            $products[$i]['image'] = ProductImage::where('product_id' , $products[$i]['id'])->pluck('image')->first();
        }
        
        $data['products'] = $products;
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    public function getbrandproducts(Request $request){
        if($request->lang == 'en'){
            $products = Product::select('id', 'title_en as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->where('reviewed', 1)->where('brand_id' , $request->brand_id)->simplePaginate(16);
        }else{
            $products = Product::select('id', 'title_ar as title' , 'final_price' , 'price_before_offer' , 'offer' , 'offer_percentage' , 'category_id' )->where('deleted' , 0)->where('hidden' , 0)->where('remaining_quantity', '>', 0)->where('reviewed', 1)->where('brand_id' , $request->brand_id)->simplePaginate(16);
        }


        for($i = 0; $i < count($products); $i++){
            
            if(auth()->user()){
                $user_id = auth()->user()->id;

                $prevfavorite = Favorite::where('product_id' , $products[$i]['id'])->where('user_id' , $user_id)->first();
                if($prevfavorite){
                    $products[$i]['favorite'] = true;
                }else{
                    $products[$i]['favorite'] = false;
                }

            }else{
                $products[$i]['favorite'] = false;
            }

            if($request->lang == 'en'){
                $products[$i]['category_name'] = Category::where('id' , $products[$i]['category_id'])->pluck('title_en as title')->first();
            }else{
                $products[$i]['category_name'] = Category::where('id' , $products[$i]['category_id'])->pluck('title_ar as title')->first();
            }
            
            $products[$i]['image'] = ProductImage::where('product_id' , $products[$i]['id'])->pluck('image')->first();
        }
        
        $data['products'] = $products;
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);

    }

    public function get_sub_category_products(Request $request){
        $validator = Validator::make($request->all(), [
            'sub_category_id' => 'required',
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $sub_category_id = $request->sub_category_id;

        
        
        if($request->lang == 'en'){
            $data['sub_categories_name'] = SubCategory::where('deleted' , 0)->where('id' , $sub_category_id)->pluck('title_en as title')->first();
            $products = Product::select('id', 'title_en as title' , 'offer' , 'offer_percentage', 'multi_options' )->where('deleted' , 0)->where('hidden' , 0)->where('sub_category_id' , $request->sub_category_id)->where('sub_category_id' , $request->sub_category_id)->simplePaginate(16);
            $products->makeHidden(['multiOptions']);
        }else{
            $data['sub_categories_name'] = SubCategory::where('deleted' , 0)->where('id' , $sub_category_id)->pluck('title_ar as title')->first();
            $products = Product::select('id', 'title_ar as title' , 'offer' , 'offer_percentage', 'multi_options' )->where('deleted' , 0)->where('hidden' , 0)->where('sub_category_id' , $request->sub_category_id)->where('sub_category_id' , $request->sub_category_id)->simplePaginate(16);
            $products->makeHidden(['multiOptions']);
        }
        

        for($i = 0; $i < count($products); $i++){
            if ($products[$i]['multi_options'] == 1) {
                if (count($products[$i]['multiOptions']) > 0) {
                    $products[$i]['final_price'] = $products[$i]['multiOptions'][0]['final_price'];
                    $products[$i]['price_before_offer'] = $products[$i]['multiOptions'][0]['price_before_offer'];
                    unset($products[$i]['multi_options']);
                }
            }else {
                if($request->lang == 'en'){
                    $products[$i] = Product::select('id', 'title_en as title' , 'offer' , 'final_price', 'price_before_offer', 'offer_percentage' )->where('id', $products[$i]['id'])->where('remaining_quantity', '>', 0)->first();
                    
                }else {
                    $products[$i] = Product::select('id', 'title_ar as title' , 'offer' , 'final_price', 'price_before_offer', 'offer_percentage' )->where('id', $products[$i]['id'])->where('remaining_quantity', '>', 0)->first();
                }
            }
            
            if(auth()->user()){
                $user_id = auth()->user()->id;

                $prevfavorite = Favorite::where('product_id' , $products[$i]['id'])->where('user_id' , $user_id)->first();
                if($prevfavorite){
                    $products[$i]['favorite'] = true;
                }else{
                    $products[$i]['favorite'] = false;
                }
                
            }else{
                $products[$i]['favorite'] = false;
            }
            
            $products[$i]['image'] = ProductImage::where('product_id' , $products[$i]['id'])->pluck('image')->first();
        }
        
        // dd($products);
        $data['products'] = $products;
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    public function getStoreProducts(Request $request, $storeId) {
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            'category_id' => 'required',
            'type_id' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }
        
        $visitor = Visitor::where('unique_id' , $request->unique_id)->first();
        

        if (isset($visitor['id'])) {
            $address = Address::where('visitor_id', $visitor['id'])->first();
            $deliveryArea = DeliveryArea::where('area_id', $address['address_id'])->where('store_id', $storeId)->first();
            $storeAreas = DeliveryArea::where('store_id', $storeId)->pluck('area_id')->toArray();
            // dd($storeAreas);
            $data['store'] = Shop::where('id', $storeId)->where('status', 1)->select('id', 'logo', 'name', 'min_order_cost')->first()->makeHidden('custom');
            if (! in_array($address['address_id'], $storeAreas)) {
                $response = APIHelpers::createApiResponse(true , 406 , 'This store is not cover your area' , 'هذا المتجر لا يغطى منطقتك' , null , $request->lang);
                return response()->json($response , 406);
            }
            $data['store']['delivery_cost'] = number_format((float)$deliveryArea['delivery_cost'], 3, '.', '');
            $data['store']['min_order_cost'] = number_format((float)$data['store']['min_order_cost'], 3, '.', '');
            $data['store']['estimated_arrival_time'] = $deliveryArea['estimated_arrival_time'];
            $proTypes = Product::where('store_id', $storeId)->where('deleted', 0)->where('hidden', 0);
            if ($request->category_id && $request->category_id != 0) {
                $proTypes = $proTypes->where('category_id', $request->category_id);
            }
            $proTypes = $proTypes->pluck('type')->toArray();
            // dd($proTypes);
            $unrepeatedTypes1 = array_unique($proTypes);
            $unrepeatedTypes = [];
            if (count($unrepeatedTypes1) > 0) {
                foreach ($unrepeatedTypes1 as $key => $value) {
                    array_push($unrepeatedTypes, $value); 
                }
            }
            $productCategories = Product::where('deleted', 0)->where('hidden', 0)->where('reviewed', 1)->where('store_id', $storeId)->pluck('category_id')->toArray();
            if ($request->lang == 'en') {
                
                $data['categories'] = Category::whereIn('id', $productCategories)
                ->where('deleted', 0)
                ->select('id', 'title_en as title', 'image')->get()->toArray();
                $all = [
                    'id' => 0,
                    'title' => 'All',
                    'image' => 'all_liwbsi_nkti8l.png',
                    'selected' => false
                ];
                
                array_unshift($data['categories'], $all);

                $data['types'] = ProductType::whereIn('id', $unrepeatedTypes)->select('id', 'type_en as type')->get();
                
            }else {
                $data['categories'] = Category::whereIn('id', $productCategories)
                ->where('deleted', 0)
                ->select('id', 'title_ar as title', 'image')->get()->toArray();
                // dd($data['categories']);
                $all = [
                    'id' => 0,
                    'title' => 'الكل',
                    'image' => 'all_liwbsi_nkti8l.png',
                    'selected' => false
                ];
                
                array_unshift($data['categories'], $all);

                $data['types'] = ProductType::whereIn('id', $unrepeatedTypes)->select('id', 'type_ar as type')->get();
            }

            for ($n = 0; $n < count($data['categories']); $n ++) {
                $data['categories'][$n]['selected'] = false;
            }

            for ($m = 0; $m < count($data['types']); $m ++) {
                $data['types'][$m]['selected'] = false;
            }

            if ($request->category_id == 0) {
                $data['categories'][0]['selected'] = true;
                
                $tpe = $data['types'][0]['id'];
                if($request->type_id) {
                    $tpe = $request->type_id;
                }else {
                    $data['types'][0]['selected'] = true;
                }
				for ($f = 0; $f < count($data['types']); $f ++) {
                    if ($request->type_id == $data['types'][$f]['id']) {
                        $data['types'][$f]['selected'] = true;
                    }
                }
                if ($request->lang == 'en') {
                    
                    $data['products'] = Product::where('deleted', 0)
                    ->where('hidden', 0)
                    ->where('reviewed', 1)
                    ->where('store_id', $storeId)
                    // ->where('category_id', $productCategories[0])
                    ->where('type', $tpe)
                    ->select('id', 'title_en as title', 'offer', 'final_price', 'price_before_offer', 'offer_percentage')
                    ->orderBy('id', 'desc')
                    ->get()->makeHidden('mainImage');
                }else {
                    $data['products'] = Product::where('deleted', 0)
                    ->where('hidden', 0)
                    ->where('reviewed', 1)
                    ->where('store_id', $storeId)
                    // ->where('category_id', $productCategories[0])
                    ->where('type', $tpe)
                    ->select('id', 'title_ar as title', 'offer', 'final_price', 'price_before_offer', 'offer_percentage')
                    ->orderBy('id', 'desc')
                    ->get()->makeHidden('mainImage');
                }
                
            }else {
                for ($k = 0; $k < count($data['categories']); $k ++) {
                    if ($request->category_id == $data['categories'][$k]['id']) {
                        $data['categories'][$k]['selected'] = true;
                    }
                }
                //dd($data['types']);
                $tpe = $data['types'][0]['id'];
                if($request->type_id) {
                    $tpe = $request->type_id;
                }else {
                    $data['types'][0]['selected'] = true;
                }
                for ($f = 0; $f < count($data['types']); $f ++) {
                    if ($request->type_id == $data['types'][$f]['id']) {
                        $data['types'][$f]['selected'] = true;
                    }
                }
                
                if ($request->lang == 'en') {
                    $data['products'] = Product::where('deleted', 0)
                    ->where('hidden', 0)
                    ->where('reviewed', 1)
                    ->where('store_id', $storeId)
                    ->where('category_id', $request->category_id)
                    ->where('type', $tpe)
                    ->where('remaining_quantity', '>', 0)
                    ->select('id', 'title_en as title', 'offer', 'final_price', 'price_before_offer', 'offer_percentage')
                    ->orderBy('id', 'desc')
                    ->get()->makeHidden('mainImage');
                }else {
                    $data['products'] = Product::where('deleted', 0)
                    ->where('hidden', 0)
                    ->where('reviewed', 1)
                    ->where('store_id', $storeId)
                    ->where('category_id', $request->category_id)
                    ->where('type', $tpe)
                    ->where('remaining_quantity', '>', 0)
                    ->select('id', 'title_ar as title', 'offer', 'final_price', 'price_before_offer', 'offer_percentage')
                    ->orderBy('id', 'desc')
                    ->get()->makeHidden('mainImage');
                }

                
            }

            for ($p = 0; $p < count($data['products']); $p ++) {
                if(auth()->user()){
                    $user_id = auth()->user()->id;
    
                    $prevfavorite = Favorite::where('product_id' , $data['products'][$p]['id'])->where('user_id' , $user_id)->first();
                    if($prevfavorite){
                        $data['products'][$p]['favorite'] = true;
                    }else{
                        $data['products'][$p]['favorite'] = false;
                    }
                    
                }else{
                    $data['products'][$p]['favorite'] = false;
                }
                $data['products'][$p]['final_price'] = number_format((float)$data['products'][$p]['final_price'], 3, '.', '');
                $data['products'][$p]['price_before_offer'] = number_format((float)$data['products'][$p]['price_before_offer'], 3, '.', '');
                if (isset($data['products'][$p]->mainImage)) {
                    $data['products'][$p]['image'] = $data['products'][$p]->mainImage['image'];
                }else {
                    $data['products'][$p]['image'] = "";
                }
                
            }
            

        }else {
            $response = APIHelpers::createApiResponse(true , 406 , 'This Unique Id Not Registered' , 'This Unique Id Not Registered' , null , $request->lang);
            return response()->json($response , 406);
        }
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }
    

}