<?php

namespace App\Http\Controllers\Dashboard;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Helpers\APIHelpers;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use App\Shop;
use App\DeliveryArea;
use App\Area;
use App\StoreNotification;


class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:dashboard' , ['except' => []]);
    }
    // get profile
    public function getProfile(Request $request) {
        $user = Auth::guard('dashboard')->user();
        $data['username'] = $user->name;
        $data['phone'] = $user->phone;
        $data['email'] = $user->email;
        $data['min_order_cost'] = $user->min_order_cost;
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    // update profile
    public function updateProfile(Request $request) {
        $post = $request->all();
        $user = Shop::find(Auth::guard('dashboard')->user()->id);

        $user->update($post);

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , '' , $request->lang);
        return response()->json($response , 200);
    }

    // reset password
    public function resetpassword(Request $request){
        $validator = Validator::make($request->all() , [
            'password' => 'required',
			"old_password" => 'required'
        ]);

        if($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $user = Auth::guard('dashboard')->user();
        
		if(!Hash::check($request->old_password, $user->password)){
			$response = APIHelpers::createApiResponse(true , 406 , 'Wrong old password' , 'كلمه المرور السابقه خطأ' , null , $request->lang);
            return response()->json($response , 406);
		}
		if($request->old_password == $request->password){
			$response = APIHelpers::createApiResponse(true , 406 , 'You cannot set the same previous password' , 'لا يمكنك تعيين نفس كلمه المرور السابقه' , null , $request->lang);
            return response()->json($response , 406);
		}
        Shop::where('id' , $user->id)->update(['password' => Hash::make($request->password)]);
        $newuser = Shop::find($user->id);
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $newuser , $request->lang);
        return response()->json($response , 200);
    }

    // get areas
    public function getAreas(Request $request) {

        if ($request->lang == 'en') {
            if (isset($request->search) && !empty($request->search)) {
                $data['areas'] = Area::where('areas.deleted', 0)
                                ->where('title_en', 'like', '%' . $request->search . '%')
                                ->orWhere('title_ar', 'like', '%' . $request->search . '%')
                                ->select('title_en as title', 'id as area_id')
                                ->get();
            }else {
                $data['areas'] = Area::where('areas.deleted', 0)
                                ->select('title_en as title', 'id as area_id')
                                ->get();
            }
            
        }else {
            if (isset($request->search) && !empty($request->search)) {
                $data['areas'] = Area::where('areas.deleted', 0)
                                ->where('title_en', 'like', '%' . $request->search . '%')
                                ->orWhere('title_ar', 'like', '%' . $request->search . '%')
                                ->select('title_ar as title', 'id as area_id')
                                ->get();
            }else {
                $data['areas'] = Area::where('areas.deleted', 0)
                                ->select('title_en as title', 'id as area_id')
                                ->get();
            }
            
        }

        

        for($i = 0; $i < count($data['areas']); $i ++) {
            $deliveryArea = DeliveryArea::where('area_id', $data['areas'][$i]['area_id'])
            ->where('store_id', Auth::guard('dashboard')->user()->id)
            ->select('delivery_cost', 'estimated_arrival_time', 'id')
            ->first();
            if (isset($deliveryArea['id'])) {
                $data['areas'][$i]['delivery_cost'] = $deliveryArea['delivery_cost'];
                $data['areas'][$i]['estimated_arrival_time'] = $deliveryArea['estimated_arrival_time'];
            }else {
                $data['areas'][$i]['delivery_cost'] = "not set";
                $data['areas'][$i]['estimated_arrival_time'] = "not set";
            }
            
        }
        

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    // update delivery areas
    public function updateDeliveryAreas(Request $request) {
        $post = $request->all();
        $validator = Validator::make($request->all(), [
            'area_id' => 'required',
            'delivery_cost' => 'numeric',
            'estimated_arrival_time' => 'numeric|min:1'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة'  , null , $request->lang);
            return response()->json($response , 406);
        }
        $deliveryArea = DeliveryArea::where('area_id', $post['area_id'])
                        ->where('store_id', Auth::guard('dashboard')->user()->id)
                        ->select('delivery_cost', 'estimated_arrival_time', 'id')
                        ->first();
        if (isset($deliveryArea['id'])) {
            $deliveryArea->update($post);
        }else {
            $post['store_id'] = Auth::guard('dashboard')->user()->id;
            DeliveryArea::create($post);
        }

        $response = APIHelpers::createApiResponse(false , 200 , '' , '', (object)[] , $request->lang);
        return response()->json($response , 200);
    }

    // get notifications
    public function getNotifications(Request $request) {
        $data = StoreNotification::find(Auth::guard('dashboard')->user()->id);

        $response = APIHelpers::createApiResponse(false , 200 , '' , '', $data , $request->lang);
        return response()->json($response , 200);
    }


}