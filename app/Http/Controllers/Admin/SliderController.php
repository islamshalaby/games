<?php
namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Admin\AdminController;
use Illuminate\Http\Request;
use JD\Cloudder\Facades\Cloudder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Slider;
use App\Ad;
use App\SliderAd;

class SliderController extends AdminController{
    // show sliders
    public function show() {
        $data['sliders'] = Slider::get();

        return view('admin.sliders', ['data' => $data]);
    }

    // add get
    public function AddGet() {
        $data['ads'] = Ad::where('place', 1)->get();

        return view('admin.slider_form', ['data' => $data]);
    }

    // add post
    public function AddPost(Request $request) {
        $post = $request->all();
        $slider = Slider::create(['type' => $post['type']]);
        if (count($post['ads']) > 0) {
            for ($i = 0; $i < count($post['ads']); $i ++) {
                SliderAd::create(['slider_id' => $slider['id'], 'ad_id' => $post['ads'][$i]]);
            }
        }

        return redirect()->route('sliders.show');
    }

    // Edit get
    public function EditGet(Slider $slider) {
        $data['ads'] = Ad::where('place', 1)->get();
        $data['slider_ads'] = SliderAd::where('slider_id', $slider->id)->pluck('ad_id')->toArray();
        $data['slider'] = $slider;

        return view('admin.slider_edit', ['data' => $data]);
    }

    // Edit post
    public function EditPost(Request $request, Slider $slider) {
        $slider->ads()->sync($request->ads);

        return redirect()->route('sliders.show');
    }

    // details
    public function details(Slider $slider) {
        $data['slider'] = $slider->ads;

        return view('admin.slider_details', ['data' => $data]);
    }
}