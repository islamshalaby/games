<?php
namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Admin\AdminController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Area;
use App\DeliveryArea;
use App\Shop;

class AreasController extends AdminController{
    // get all areas
    public function show(){
        $data['areas'] = Area::where('deleted', 0)->orderBy('id' , 'desc')->get();
        return view('admin.areas' , ['data' => $data]);
    }

    // add get
    public function addGet() {
        return view('admin.area_form');
    }

    // add post
    public function AddPost(Request $request){
        Area::create($request->all());
        return redirect()->route('areas.index');
    }

    // get edit page
    public function EditGet(Area $area){
        $data['area'] = $area;
        return view('admin.area_edit' , ['data' => $data ]);
    }

    // edit area
    public function EditPost(Request $request, Area $area){
        $post = $request->all();
        if (isset($post['lat']) && isset($post['long'])) {
            $geocode=file_get_contents('https://maps.googleapis.com/maps/api/geocode/json?latlng=' . $post['lat'] . ',' . $post['long'] . '&sensor=true&key=AIzaSyCMSfq40Bo2KuQvQVSQE1gmmgJdxEbDS0Y&libraries');
            $output= json_decode($geocode);
            // echo "<pre>";
            // print_r($output);
            // echo "</pre>";
            // dd();
            $post['formatted_address'] = $output->results[2]->formatted_address;
        }
        // dd($post);
        $area->update($post);

        return redirect()->route('areas.index');
    }

    // delete
    public function delete(Area $area) {
        $area->update(['deleted' => 1]);

        return redirect()->back();
    }

    // details
    public function details(Area $area) {
        $data['area'] = $area;

        return view('admin.area_details', ['data' => $data]);
    }

    // get add delivery costs
    public function add_deliver_cost_get(Area $area) {
        $data['area'] = $area;
        $d_areas = DeliveryArea::where('area_id', $area->id)->pluck('store_id')->toArray();
        $data['stores'] = Shop::whereNotIn('id', $d_areas)->where('status', 1)->get();

        return view('admin.deliver_cost_form', ['data' => $data]);
    }

    // post add delivery costs
    public function add_deliver_cost_post(Request $request, Area $area) {
        $post = $request->all();
        $post['area_id'] = $area->id;
        DeliveryArea::create($post);

        return redirect()->route('areas.show.delivercost', $area->id);
    }

    // show delivery costs
    public function show_delivery_costs(Area $area) {
        $data['area'] = $area;
        $data['costs'] = DeliveryArea::where('area_id', $area->id)->get();
        $areas = DeliveryArea::where('area_id', $area->id)->count();
        $stores = Shop::where('status', 1)->count();
        
        $data['show_add'] = true;
        if ($areas == $stores) {
            $data['show_add'] = false;
        }

        // dd($data['show_add']);

        return view('admin.delivery_costs', ['data' => $data]);
    }

    // get edit delivery cost
    public function edit_delivery_cost_get(Area $area, DeliveryArea $cost) {
        $data['area'] = $area;
        
        $data['cost'] = $cost;

        return view('admin.deliver_cost_edit', ['data' => $data]);
    }

    // post edit deliver cost
    public function edit_delivery_cost_post(Request $request, Area $area, DeliveryArea $cost) {
        $post = $request->all();

        $cost->update($post);

        return redirect()->route('areas.show.delivercost', $area->id);
    }

    public function test() {
        
        $geocode=file_get_contents('https://maps.googleapis.com/maps/api/geocode/json?latlng=29.3417571,48.0257676&sensor=true&key=AIzaSyCMSfq40Bo2KuQvQVSQE1gmmgJdxEbDS0Y&libraries');
        // dd($geocode);
        $output= json_decode($geocode);

        echo "<pre>";
        print_r($output->results);
        echo "</pre>";
    }
}