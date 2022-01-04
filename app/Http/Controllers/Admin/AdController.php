<?php
namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Admin\AdminController;
use Illuminate\Http\Request;
use JD\Cloudder\Facades\Cloudder;
use Illuminate\Support\Facades\DB;
use App\Ad;
use App\Category;
use App\Product;
use App\Shop;

class AdController extends AdminController{
    
    // type get 
    public function AddGet(){
        return view('admin.ad_form');
    }

    // type post
    public function AddPost(Request $request){
        $image_name = $request->file('image')->getRealPath();
        Cloudder::upload($image_name, null);
        $imagereturned = Cloudder::getResult();
        $image_id = $imagereturned['public_id'];
        $image_format = $imagereturned['format'];    
        $image_new_name = $image_id.'.'.$image_format;
        $ad = new Ad();
        $ad->image = $image_new_name;
        $ad->content = $request->content;
        $ad->place = $request->place;
        $ad->type = $request->type;
        if (isset($request->store_id)) {
            $ad->store_id = $request->store_id;
        }
        if (isset($request->content_type)) {
            $ad->content_type = $request->content_type;
        }
        
        $ad->save();
        return redirect('admin-panel/ads/show'); 
    }


        // get all ads
        public function show(Request $request){
            $data['ads'] = Ad::orderBy('id' , 'desc')->get();
            return view('admin.ads' , ['data' => $data]);
        }
    
        // get edit page
        public function EditGet(Request $request){
            $data['ad'] = Ad::find($request->id);
            // dd($data['ad']);
            return view('admin.ad_edit' , ['data' => $data]);
        }
    
        // post edit ad
        public function EditPost(Request $request){
            $ad = Ad::find($request->id);
            if($request->file('image')){
                $image = $ad->image;
                $publicId = substr($image, 0 ,strrpos($image, "."));    
                Cloudder::delete($publicId);
                $image_name = $request->file('image')->getRealPath();
                Cloudder::upload($image_name, null);
                $imagereturned = Cloudder::getResult();
                $image_id = $imagereturned['public_id'];
                $image_format = $imagereturned['format'];    
                $image_new_name = $image_id.'.'.$image_format;
                $ad->image = $image_new_name;
            }
            $ad->type = $request->type;
            $ad->place = $request->place;
            if (isset($request->content_type)) {
                $ad->content_type = $request->content_type;
            }
            if(isset($request->store_id)) {
                $ad->store_id = $request->store_id;
            }
            $ad->content = $request->content;
            
            $ad->save();
            return redirect('admin-panel/ads/show');
        }
    
        public function details($id){
            
            $data['ad'] = Ad::find($id);
            
            if ($data['ad']['type'] == 1) {
                if ($data['ad']['content_type'] == 1) {
                    $data['product'] = Product::find($data['ad']['content']);
                }else if($data['ad']['content_type'] == 2) {
                    $data['category'] = Category::find($data['ad']['content']);
                }else if($data['ad']['content_type'] == 3) {
                    $data['store'] = Shop::find($data['ad']['content']);
                }
            }
            
            return view('admin.ad_details' , ['data' => $data]);
        }
    
        public function delete(Request $request){
            $ad = Ad::find($request->id);
            if($ad){
                $ad->delete();
            }
            return redirect('admin-panel/ads/show');
        }
    
        public function fetch_products() {
            $row = Product::where('deleted', 0)->where('hidden', 0)->whereHas('store', function($q){
                $q->where('status', 1);
            })->where('remaining_quantity', '>', 0)->where('reviewed', 1)->orderBy('id' , 'desc')->get();
            $data = json_decode($row);
    
            return response($data, 200);
        }

        public function fetch_categories() {
            $row = Category::where('deleted', 0)->orderBy('id' , 'desc')->get();
            $data = json_decode($row);
    
            return response($data, 200);
        }

        public function fetch_store_categories(Shop $store) {
            $row = Category::join('products','products.category_id', '=', 'categories.id')
            ->where('products.store_id', $store->id)
            ->select('categories.id', 'categories.title_en', 'categories.title_ar')
            ->groupBy('categories.id')
            ->groupBy('categories.title_en')
            ->groupBy('categories.title_ar')
            ->orderBy('id', 'desc')->get();
            $data = json_decode($row);
            // dd($row);
            return response($data, 200);
        }

        public function fetch_stores() {
            $row = Shop::where('status', 1)->orderBy('id' , 'desc')->get();
            $data = json_decode($row);
    
            return response($data, 200);
        }
}