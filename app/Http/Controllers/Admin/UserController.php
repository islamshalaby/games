<?php
namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Admin\AdminController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Helpers\APIHelpers;
use JD\Cloudder\Facades\Cloudder;
use App\User;
use App\Notification;
use App\UserNotification;
use App\UserAddress;
use App\Visitor;


class UserController extends AdminController{

    // get all users
    public function show(Request $request){
        $data['users'] = User::orderBy('id','desc')->get();
        return view('admin.users' , ['data' => $data]);
    }

    // get user details
    public function details(Request $request){
        $data['user'] = User::find($request->id);
        $data['user']->seen = 1;
        $data['user']->save();
        return view('admin.user_details' , ['data' => $data]);
    }

    // edit user details
    public function edit(Request $request){
        $data['user'] = User::find($request->id);
        return view('admin.user_edit' , ['data' => $data]);
    }

    // edit user Post Method
    public function EditPost(Request $request){
        $check_user_phone = User::where('phone' , $request->phone)->where('id' , '!=' , $request->id)->first();
        if($check_user_phone){
            return redirect('admin-panel/users/edit/'.$request->id)->with('status', 'Phone Exists Before');
        }
        
        $check_user_mail = User::where('email' , $request->email)->where('id' , '!=' , $request->id)->first();
        if($check_user_mail){
            return redirect('admin-panel/users/edit/'.$request->id)->with('status', 'Email Exists Before');
        }

        $current_user = User::find($request->id);
        $current_user->name = $request->name;
        $current_user->phone = $request->phone;
        $current_user->email = $request->email;
        if($request->password){
            $current_user->password = Hash::make($request->password);
        }
        $current_user->save();
        return redirect('admin-panel/users/show');
    }

    // get add user 
    public function AddGet(Request $request){
        return view('admin.user_form');
    }

    // post add user
    public function AddPost(Request $request){
        $check_user_phone = User::where('phone' , $request->phone)->first();
        if($check_user_phone){
            return redirect('admin-panel/users/add')->with('status', 'Phone Exists Before');
        }

        $check_user_mail = User::where('email' , $request->email)->first();
        if($check_user_mail){
            return redirect('admin-panel/users/add')->with('status', 'Email Exists Before');
        }

        $user = new User();
        $user->name = $request->name;
        $user->phone = $request->phone;
        $user->email = $request->email;
        $user->password = Hash::make($request->password);
        $user->save();
        return redirect('admin-panel/users/show');
    }

    // send notifications
    public function SendNotifications(Request $request){
        $user = Visitor::select('id','fcm_token', 'user_id')->where('user_id', $request->id)->first();
        $users = Visitor::where('user_id', $request->id)->pluck('fcm_token');
        $fcm_token = $user->fcm_token;

        if(!$users){
            return redirect('admin-panel/users/details/'.$request->id)->with('error', 'Empty Fcm Token');
        }

        if($request->file('image')){
            $image_name = $request->file('image')->getRealPath();
            Cloudder::upload($image_name, null);
            $imagereturned = Cloudder::getResult();
            $image_id = $imagereturned['public_id'];
            $image_format = $imagereturned['format'];    
            $image_new_name = $image_id.'.'.$image_format;
        }else{
            $image_new_name = null;
        }

        $insert_notification = new Notification();
        $insert_notification->image = $image_new_name;
        $insert_notification->title = $request->title;
        $insert_notification->body = $request->body;
        $insert_notification->save();

        $user_notification = new UserNotification();
        $user_notification->notification_id = $insert_notification->id;
        $user_notification->visitor_id = $user->id;
        $user_notification->user_id = $request->id;
        $user_notification->save();
		
		$the_image = "https://res.cloudinary.com/ddcmwwmwk/image/upload/w_200,q_100/v1581928924/".$image_new_name;
        
        $notification = APIHelpers::send_notification($request->title , $request->body , $the_image , null , $users);
        $json_notification = json_decode($notification);
        if($json_notification->success){
             return redirect('admin-panel/users/details/'.$request->id)->with('status', 'Sent');
        }else{
             return redirect('admin-panel/users/details/'.$request->id)->with('error', 'Failed');
        }
               
    }

    // block user
    public function block(Request $request){
        $user = User::find($request->id);
        $user->active = 0;
        $user->save();
        return redirect()->back();
    }

    // active user
    public function active(Request $request){
        $user = User::find($request->id);
        $user->active = 1;
        $user->save();
        return redirect()->back();
    }

    // get user addresses
    public function get_user_addresses(User $user) {
        $data['addresses'] = $user->addresses;
        $data['username'] = $user->name;

        return view('admin.addresses', ['data' => $data]);
    }

    // address details
    public function address_details(UserAddress $address) {
        $data['address'] = $address;

        return view('admin.address_details', ['data' => $data]);
    }


}