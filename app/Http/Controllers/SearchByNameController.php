<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Address;
use App\Visitor;
use App\ProductImage;
use Illuminate\Support\Facades\Validator;
use App\Helpers\APIHelpers;

class SearchByNameController extends Controller
{
        public function Search(Request $request)
        {
            $validator = Validator::make($request->all(), [
                'search' => 'required',
                'unique_id' => 'required'   
            ]);

            if($validator->fails()){
                $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null, $request->lang);
                return response()->json($response , 406);
            }

            $search = $request->search;
            $visitor = Visitor::select('id')->where('unique_id', $request->unique_id)->first();
            $address = Address::where('visitor_id', $visitor['id'])->first();


            if ($request->lang == 'en') {
                $data['products'] = Product::where('products.deleted', 0)
                ->where('products.hidden', 0)
                ->Where(function($query) use ($search) {
                    $query->Where('products.title_en', 'like', '%' . $search . '%')->orWhere('products.title_ar', 'like', '%' . $search . '%');
                })
                ->where('delivery_areas.area_id', $address['address_id'])
                ->leftjoin('delivery_areas', function($join) {
                    $join->on('delivery_areas.store_id', '=', 'products.store_id');
                })
                ->leftjoin('categories', function($join) {
                    $join->on('categories.id', '=', 'products.category_id');
                })
                ->select('products.id', 'products.title_en as title', 'products.offer', 'products.final_price', 'products.price_before_offer', 'products.offer_percentage')
                ->addSelect('categories.title_en as category_name')
                ->groupBy('products.id')
                ->groupBy('products.title_en')
                ->groupBy('products.offer')
                ->groupBy('products.final_price')
                ->groupBy('products.price_before_offer')
                ->groupBy('products.offer_percentage')
                ->groupBy('products.category_id')
                ->groupBy('categories.title_en')
                ->orderBy('products.id', 'desc')
                ->get()->makeHidden('mainImage');
            }else {
                $data['products'] = Product::where('products.deleted', 0)
                ->where('products.hidden', 0)
                ->Where(function($query) use ($search) {
                    $query->Where('products.title_en', 'like', '%' . $search . '%')->orWhere('products.title_ar', 'like', '%' . $search . '%');
                })
                ->where('delivery_areas.area_id', $address['address_id'])
                ->leftjoin('delivery_areas', function($join) {
                    $join->on('delivery_areas.store_id', '=', 'products.store_id');
                })
                ->where('categories.deleted', 0)
                ->leftjoin('categories', function($join) {
                    $join->on('categories.id', '=', 'products.category_id');
                })
                ->select('products.id', 'products.title_ar as title', 'products.offer', 'products.final_price', 'products.price_before_offer', 'products.offer_percentage', 'products.category_id')
                ->addSelect('categories.title_ar as category_name')
                ->groupBy('products.id')
                ->groupBy('products.title_ar')
                ->groupBy('products.offer')
                ->groupBy('products.final_price')
                ->groupBy('products.price_before_offer')
                ->groupBy('products.offer_percentage')
                ->groupBy('products.category_id')
                ->groupBy('categories.title_ar')
                ->orderBy('products.id', 'desc')
                ->get()->makeHidden('mainImage');
            }
            for ($k = 0; $k < count($data['products']); $k ++) {
                $data['products'][$k]['image'] = $data['products'][$k]->mainImage->image;
            }


            $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data['products'] , $request->lang) ;
            return response()->json($response , 200);
        }
}
