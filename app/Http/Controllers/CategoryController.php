<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use App\Helpers\APIHelpers;
use App\Category;
use App\Brand;
use App\Product;
use App\SubCategory;
use App\GoldPrice;


class CategoryController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api' , ['except' => ['getcategories' , 'get_sub_categories']]);
    }

    public function getcategories(Request $request){
        $data = [];
        if($request->lang == 'en'){
            $data['categories'] = Category::where('deleted' , 0)->select('id' , 'title_en as title' , 'image')->withCount('recent_products')->get(); 
            $data['gold_prices'] = GoldPrice::select('price', 'title_en as title')->get();
        }else{
            $data['categories'] = Category::where('deleted' , 0)->select('id' , 'title_ar as title' , 'image')->withCount('recent_products')->get();   
            $data['gold_prices'] = GoldPrice::select('price', 'title_en as title')->get();
        }
         
        // for($i = 0 ; $i < count($categories); $i++){
        //     if($request->lang == 'en'){
        //         $categories[$i]['brands'] = Brand::where('deleted' , 0)->where('category_id' , $categories[$i]['id'])->select('id' , 'title_en as title')->get();
        //     }else{
        //         $categories[$i]['brands'] = Brand::where('deleted' , 0)->where('category_id' , $categories[$i]['id'])->select('id' , 'title_ar as title')->get();
        //     }

        //     for($j = 0; $j < count($categories[$i]['brands']); $j++){
        //         if($request->lang == 'en'){
        //             $categories[$i]['brands'][$j]['sub_categories'] = SubCategory::where('deleted' , 0)->where('brand_id' , $categories[$i]['brands'][$j]['id'])->where('category_id' , $categories[$i]['id'])->select('id' , 'image' , 'title_en as title')->get();
        //         }else{
        //             $categories[$i]['brands'][$j]['sub_categories'] = SubCategory::where('deleted' , 0)->where('brand_id' , $categories[$i]['brands'][$j]['id'])->where('category_id' , $categories[$i]['id'])->select('id' , 'image' , 'title_ar as title')->get();
        //         }
        //     }
            
        // }

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }
	
	public function get_sub_categories(Request $request){


                if($request->lang == 'en'){
                    $data['category_name'] = Category::find($request->category_id)['title_en'];
                    $data['sub_categories'] = SubCategory::where('deleted' , 0)->where('category_id' , $request->category_id)->select('id' , 'image' , 'title_en as title')->withCount('recent_products')->limit(6)->get();
                }else{
                    $data['category_name'] = Category::find($request->category_id)['title_ar'];
                    $data['sub_categories'] = SubCategory::where('deleted' , 0)->where('category_id' , $request->category_id)->select('id' , 'image' , 'title_ar as title')->withCount('recent_products')->limit(6)->get();
                }
            
		
            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
            return response()->json($response , 200);
    }

    // get store categories
    // public function get_store_categories($id) {
    //     $products = Product::where('store_id', $id)->get();
    //     $categories = 
    // }
    
    
	
	

}    