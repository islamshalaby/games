<?php

namespace App\Http\Controllers\Dashboard;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Helpers\APIHelpers;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use App\Order;
use App\UserAddress;
use App\User;
use App\OrderItem;

class OrderController extends Controller
{
    // get orders
    public function getOrders(Request $request) {
        $validator = Validator::make($request->all(), [
            'status' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة'  , null , $request->lang);
            return response()->json($response , 406);
        }

        $query = Order::where('store_id', Auth::guard('dashboard')->user()->id)->select('id', 'status', 'order_number', 'created_at');
        if ($request->status == 0) {
            $data['orders'] = $query->orderBy('id', 'desc')->get();
        }else {
            $data['orders'] = $query->where('status', $request->status)->orderBy('id', 'desc')->get();
        }

        for ($i = 0; $i < count($data['orders']); $i ++) {
            $data['orders'][$i]['date'] = $data['orders'][$i]['created_at']->format('Y-m-d'); 
            $data['orders'][$i]['time'] = $data['orders'][$i]['created_at']->format('g:i A');
        }

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
        
    }

    // order details
    public function orderDetails(Request $request, Order $order) {
        if ($order->store_id != Auth::guard('dashboard')->user()->id) {
            $response = APIHelpers::createApiResponse(true , 406 , 'this user has no access to this order' , 'هذا المستخدم ليس له صلة بهذا الطلب'  , null , $request->lang);
            return response()->json($response , 406);
        }
        $data['order'] = $order->where('id', $order->id)->select('id', 'order_number', 'created_at', 'total_price', 'subtotal_price', 'delivery_cost', 'payment_method', 'status')->first();
        // dd($data['order']);
        $data['order']['date'] = $data['order']['created_at']->format('Y-m-d'); 
        $data['order']['time'] = $data['order']['created_at']->format('g:i A');

        $data['order']['address'] = $order->address;
        $items = $order->oItems;
        $allItems = [];
        for ($i = 0; $i < count($items); $i ++) {
            if ($request->lang == 'en') {
                $product = $items[$i]->product_with_select_en;
            }else {
                $product = $items[$i]->product_with_select_ar;
            }
            if (!empty($items[$i]->delivered_at)) {
                $deliveredAt = $items[$i]->delivered_at->format('d/m/Y');
            }else {
                $deliveredAt = "";
            }
            $item = [
                'status' => $items[$i]->status,
                'item_id' => $items[$i]->id,
                'store_name' => Auth::guard('dashboard')->user()->name,
                'main_image' => $product->mainImage->image,
                'delivered_at' => $deliveredAt
            ];

            $newItem = (object) array_merge($product->toArray(), $item);
            
            array_push($allItems, $newItem);
        }
        $data['order']['items'] = $allItems;

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    // update order status
    public function updateOrderStatus(Request $request, Order $order) {
        if ($order->store_id != Auth::guard('dashboard')->user()->id) {
            $response = APIHelpers::createApiResponse(true , 406 , 'this user has no access to this order' , 'هذا المستخدم ليس له صلة بهذا الطلب'  , null , $request->lang);
            return response()->json($response , 406);
        }
        $validator = Validator::make($request->all(), [
            'status' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة'  , null , $request->lang);
            return response()->json($response , 406);
        }
        $order = $order->makeHidden('oItems');
        $order->update(['status' => $request->status]);

        for ($i = 0; $i < count($order->oItems); $i ++) {
            if ($request->status == 3) {
                $order->oItems[$i]->update(['status' => $request->status, 'delivered_at' => date("Y-m-d H:i:s")]);
            }else {
                $order->oItems[$i]->update(['status' => $request->status]);
            }
            
        }

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $order , $request->lang);
        return response()->json($response , 200);
    }

    // update item status
    public function updateItemStatus(Request $request, OrderItem $item) {
        
        $item->update(['status' => $request->status]);
        $order_status = 0;
        $main_order_inprogress = 0;
        $main_order_delivered = 0;
        
        
        for ($i = 0; $i < count($item->order->oItems); $i ++) {
            if ( $item->order->oItems[$i]->status == $request->status ) {
                $order_status ++;
            }
        }

        

        if ($order_status == count($item->order->oItems)) {
            $item->order->update(['status' => $item->order->oItems[0]->status]);
        }
        


        for ($n =0; $n < count($item->order->main->orders); $n ++) {
            if(in_array($request->status, [1, 2])) {
                if ( in_array($item->order->main->orders[$n]->status, [1, 2]) ) {
                    $main_order_inprogress ++;
                }
            }else if($request->status == 3) {
                if ( in_array($item->order->main->orders[$n]->status, [3, 4, 7]) ) {
                    $main_order_delivered ++;
                }
            }
        }

        if ($order_status == count($item->order->main->orders)) {
            $item->order->main->update(['status' => 1]);
        }

        if ($main_order_delivered == count($item->order->main->orders)) {
            $item->order->main->update(['status' => 3]);
        }
        
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $item , $request->lang);
        return response()->json($response , 200);
    }

    // order address details
    public function orderAddressDetails(Request $request, UserAddress $address) {
        $data['address'] = $address;
        $data['address']['user'] = User::select('id', 'name', 'phone')->find($address->user_id);

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }
}