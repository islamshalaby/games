<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\UserAddress;
use App\Visitor;
use App\Product;
use App\Cart;
use App\Order;
use App\OrderItem;
use App\DeliveryArea;
use Illuminate\Support\Facades\Validator;
use App\Helpers\APIHelpers;
use App\Shop;
use App\ProductMultiOption;
use App\MainOrder;
use App\Wallet;
use App\Setting;
use App\Retrieve;
use App\StoreNotification;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;


class OrderController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api' , ['except' => ['pay_sucess', 'pay_error', 'excute_pay']]);
    }
    
    public function create(Request $request){
        $validator = Validator::make($request->all(), [
            'unique_id' => 'required',
            'address_id' => 'required',
            'payment_method' => 'required'
        ]);

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة'  , null , $request->lang);
            return response()->json($response , 406);
        }

        $user_id = auth()->user()->id;
        $visitor  = Visitor::where('unique_id' , $request->unique_id)->first();
        $user_id_unique_id = $visitor->user_id;
        $visitor_id = $visitor->id;
        $cart = Cart::where('visitor_id' , $visitor_id)->get();
        $productIds = Cart::where('visitor_id' , $visitor_id)->pluck('product_id')->toArray();
        $sumProducts = Product::whereIn('id', $productIds)->get();

        if(count($cart) == 0){
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة'  , null , $request->lang);
            return response()->json($response , 406);
        }
        $str = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $main_order_number = substr(str_shuffle(uniqid() . $str) , -9);
        $address = UserAddress::select('area_id')->find($request->address_id);
        $stores = Shop::join('products', 'products.store_id', '=', 'shops.id')
            ->where('carts.visitor_id', $visitor_id)
            ->leftjoin('carts', function($join) {
                $join->on('carts.product_id', '=', 'products.id');
            })
            ->pluck('shops.id')
            ->toArray();
        
        $unrepeated_stores1 = array_unique($stores);
        $unrepeated_stores = [];
        foreach ($unrepeated_stores1 as $key => $value) {
			array_push($unrepeated_stores, $value); 
		}
        
        if ($request->lang == 'en') {
            $notificationTitle = "New order";
            $notificationBody = "a user has made a new order from you";
        }else {
            $notificationTitle = "طلب جديد";
            $notificationBody = "قام مستخدم بطلب جديد منك";
        }
        
        if($request->payment_method == 2){
            $main_order = MainOrder::create([
                'user_id' => auth()->user()->id,
                'address_id' => $request->address_id,
                'payment_method' => $request->payment_method,
                'main_order_number' => $main_order_number
            ]);
            if (count($stores) > 0) {
                for ($i = 0; $i < count($unrepeated_stores); $i ++) {
                    $store_products = Cart::where('store_id', $unrepeated_stores[$i])->where('visitor_id', $visitor_id)->get();
                    
                    $pluck_products = Cart::where('store_id', $unrepeated_stores[$i])->pluck('product_id')->toArray();
                    $delivery = DeliveryArea::select('delivery_cost')->where('area_id', $address['area_id'])->where('store_id', $unrepeated_stores[$i])->first();
                    // dd($delivery);
                    if (!isset($delivery['delivery_cost'])) {
                        $delivery = Setting::find(1);
                    }
                    if (count($store_products) > 0) {
                        $subtotal_price = 0;
                        for ($n = 0; $n < count($store_products); $n ++) {
                            if($store_products[$n]->product->remaining_quantity < $store_products[$n]['count']){
                                $d_main_order = MainOrder::find($main_order['id']);
                                $d_main_order->delete();
                                $response = APIHelpers::createApiResponse(true , 406 , 'The remaining amount of the product is not enough' , 'الكميه المتبقيه من المنتج غير كافيه'  , null , $request->lang);
                                return response()->json($response , 406);
                            }
                            $single_product = Product::select('id', 'remaining_quantity', 'sold_count')->where('id', $store_products[$n]['product_id'])->first();
                            $single_product->remaining_quantity = $single_product->remaining_quantity - $store_products[$n]['count'];
                            $single_product->sold_count = $single_product->sold_count - $store_products[$n]['count'];
                            $single_product->save();
                            // var_dump($store_products[$n]->product->final_price * $store_products[$n]['count']);
                            $subtotal_price = $subtotal_price + ($store_products[$n]->product->final_price * $store_products[$n]['count']);
                            
                        }
                    }

                    $shop = Shop::where('id', $unrepeated_stores[$i])->select('min_order_cost', 'name')->first();
                    if ($subtotal_price < $shop['min_order_cost']) {
                        $d_main_order = MainOrder::find($main_order['id']);
                        $d_main_order->delete();
                        $response = APIHelpers::createApiResponse(true , 406 , 'Minimum Order Cost for Store ' . $shop['name'] . ' is ' . $shop['min_order_cost'] . ' KWD' , 'الحد الأدنى لقيمة الطلب من متجر ' . $shop['name'] . ' هو ' . $shop['min_order_cost'] . ' د.ك'  , null , $request->lang);
                        return response()->json($response , 406);
                    }
                    
                    $total_cost = $delivery['delivery_cost'] + $subtotal_price;
                    
                    $order = Order::create([
                        'user_id' => auth()->user()->id,
                        'address_id' => $request->address_id,
                        'payment_method' => $request->payment_method,
                        'subtotal_price' => number_format((float)$subtotal_price, 3, '.', ''),
                        'delivery_cost' => number_format((float)$delivery['delivery_cost'], 3, '.', ''),
                        'total_price' => number_format((float)$total_cost, 3, '.', ''),
                        'order_number' => substr(str_shuffle(uniqid() . $str) , -9),
                        'store_id' => $unrepeated_stores[$i],
                        'main_id' => $main_order['id']
                        ]);

                        $count = 0;
                        for($k = 0; $k < count($store_products); $k++){
                            
                            $product_data = Product::select('final_price', 'price_before_offer')->where('id', $store_products[$k]['product_id'])->first();
                            
                            $order_item =  OrderItem::create([
                                'order_id' => $order->id,
                                'product_id' => $store_products[$k]['product_id'],
                                'option_id' => $store_products[$k]['option_id'],
                                'price_before_offer' => number_format((float)$product_data['price_before_offer'], 3, '.', ''),
                                'final_price' => number_format((float)$product_data['final_price'], 3, '.', ''),
                                'count' => $store_products[$k]['count']
                            ]);
                            $count = $count + $store_products[$k]['count'];
                            
                            $cartItem = Cart::find($store_products[$k]['id']);
                            $cartItem->delete();                       
                        }

                        $notification = new StoreNotification();
                        $notification->title = $notificationTitle;
                        $notification->body = $notificationBody;
                        $notification->store_id = $unrepeated_stores[$i];
                        $notification->save();
                        $notificationss = APIHelpers::send_notification_store($notification->title , $notification->body , null , $order , [$order->store->fcm_token]); 
					//var_dump($notificationss);
                }
            }
            $u_main_order = MainOrder::find($main_order['id']);
            $subTPrice = number_format((float)$main_order->orders->sum('subtotal_price'), 3, '.', '');
            $dCost = number_format((float)$main_order->orders->sum('delivery_cost'), 3, '.', '');
            $tPrice = number_format((float)$main_order->orders->sum('total_price'), 3, '.', '');
            $u_main_order->update([
                'subtotal_price' => $subTPrice,
                'delivery_cost' => $dCost,
                'total_price' => $tPrice
            ]);

            $data = [
                'main_order_number' => $u_main_order['main_order_number'],
                'count' => $count,
                'date' => $u_main_order['created_at']->format('Y-m-d'),
                'time' => $u_main_order['created_at']->format('g:i A'),
                'total_cost' => $tPrice
            ];
            
            
        }else if ($request->payment_method == 1) {
            if (count($stores) > 0) {
                $total_price = 0;
                for ($i = 0; $i < count($unrepeated_stores); $i ++) {
                    $store_products = Cart::where('store_id', $unrepeated_stores[$i])->where('visitor_id', $visitor_id)->get();
                    
                    $pluck_products = Cart::where('store_id', $unrepeated_stores[$i])->pluck('product_id')->toArray();
                    if (count($store_products) > 0) {
                        $subtotal_price = 0;
                        // dd(count($store_products));
                        for ($n = 0; $n < count($store_products); $n ++) {
                            if($store_products[$n]->product->remaining_quantity < $cart[$n]['count']){
                                $response = APIHelpers::createApiResponse(true , 406 , 'The remaining amount of the product is not enough' , 'الكميه المتبقيه من المنتج غير كافيه'  , null , $request->lang);
                                return response()->json($response , 406);
                            }
                            $single_product = Product::select('id', 'remaining_quantity', 'sold_count')->where('id', $store_products[$n]['product_id'])->first();
                            $single_product->remaining_quantity = $single_product->remaining_quantity - $store_products[$n]['count'];
                            $single_product->sold_count = $single_product->sold_count + $store_products[$n]['count'];
                            $single_product->save();
                            $subtotal_price = $subtotal_price + ($store_products[$n]->product->final_price * $store_products[$n]['count']);
                            
                        }
                    }
    
                    $shop = Shop::where('id', $unrepeated_stores[$i])->select('min_order_cost', 'name')->first();
                    if ($subtotal_price < $shop['min_order_cost']) {
                        $response = APIHelpers::createApiResponse(true , 406 , 'Minimum Order Cost for Store ' . $shop['name'] . ' is ' . $shop['min_order_cost'] . ' KWD' , 'الحد الأدنى لقيمة الطلب من متجر ' . $shop['name'] . ' هو ' . $shop['min_order_cost'] . ' د.ك'  , null , $request->lang);
                        return response()->json($response , 406);
                    }
                    $delivery = DeliveryArea::select('delivery_cost')->where('area_id', $address['area_id'])->where('store_id', $unrepeated_stores[$i])->first();
                    if (!isset($delivery['delivery_cost'])) {
                        $delivery = Setting::find(1);
                    }
                    $total_cost = $delivery['delivery_cost'] + $subtotal_price;
                    $total_price = $total_price + $total_cost;
                }
            }
            
            // dd($total_price);
            $root_url = $request->root();
            $user = auth()->user();
            $liveApi = 'https://api.myfatoorah.com/v2/SendPayment';
            $testApi = 'https://apitest.myfatoorah.com/v2/SendPayment';
            $liveToken = "bearer vJRsGzHd9i6dl5Rc_GfYuXkGAWiHw7ieZRsRaic4BSWg5ewxiwinosoFIXxWogGsTDxwc1hkvBVRGLzaa8EgjjRTHGRybUeE9_ju2JovpHOXvHNxK2xGLQLtx93aCK3IbLH8QxmNkkW26Sjs2mQKItKRGDrOaslIXIFbTzEZX762W7AlLuszLDwMaQv6eikMX6--r86Rc7bj_9QzAuO0RykT2ljiUFMijolgLLHl2Sb7ESSUPmP_a0SlncgFog5AlWfmBpc3CJBTQunOUXbrTgAxmmp2hueyX9bkPjoz_iWNi3pwLNULhjcxgjflaXhi8rud0KnH0fIvfHn6Ftx8E06gBkcFuoHMOTN0WaJgX-jagyAGbiINiMwqrR6StDQJ6zU7FBJiZiv5rbb5ZIcsXkt_h1DLpab9NThyKRbgoFFYe2Il7DrI4QyOtkhGZJ2xV6Wd2S0OTApzh9GxyIGEBeyTa-CpmztGKzOUauqhuyVM2ITUcnMYEeNsr-aYBlAUMZX4zl_hQDvIVBpO4ykOguTNV6rcJ-KD5EZV7Xci6l1_P2b_U-O-l-LA49RWBumd_VHbACEopmquCxtApG9Rb9qwN5HxO1HaHQehC6kc-V1vjds27412lJkKaVPOAK89KMEsB1eSSNhfvBUIE3Z1orsu_rvy2e25Aj0k7Q7v0DIU-abd8a3-Ue2xhQN15-WyKfqzxNt5czeXEtBvwYPeLZiQJl-Xp1wACoQKyqbkbjIOYA6P";
            $testToken = "bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

            $path= $liveApi;
            $token= $liveToken;
    
            $headers = array(
                'Authorization:' .$token,
                'Content-Type:application/json'
            );
            $price = $total_price;
            
            $call_back_url = $root_url."/api/excute_pay?user_id=".$user->id."&unique_id=".$request->unique_id."&address_id=".$request->address_id."&payment_method=".$request->payment_method;
            $error_url = $root_url."/api/pay/error";
            $fields =array(
                "CustomerName" => $user->name,
                "NotificationOption" => "LNK",
                "InvoiceValue" => $price,
                "CallBackUrl" => $call_back_url,
                "ErrorUrl" => $error_url,
                "Language" => "AR",
                "CustomerEmail" => $user->email
            );  
    
            $payload =json_encode($fields);
            $curl_session =curl_init();
            curl_setopt($curl_session,CURLOPT_URL, $path);
            curl_setopt($curl_session,CURLOPT_POST, true);
            curl_setopt($curl_session,CURLOPT_HTTPHEADER, $headers);
            curl_setopt($curl_session,CURLOPT_RETURNTRANSFER,true);
            curl_setopt($curl_session,CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($curl_session,CURLOPT_IPRESOLVE, CURLOPT_IPRESOLVE);
            curl_setopt($curl_session,CURLOPT_POSTFIELDS, $payload);
            $result=curl_exec($curl_session);
            curl_close($curl_session);
            $result = json_decode($result);
            $data['url'] = $result->Data->InvoiceURL;
            
        }else {
            $main_order = MainOrder::create([
                'user_id' => auth()->user()->id,
                'address_id' => $request->address_id,
                'payment_method' => $request->payment_method,
                'main_order_number' => $main_order_number
            ]);
            $ordersIds = [];
            if (count($stores) > 0) {
                $total_price = 0;
                for ($i = 0; $i < count($unrepeated_stores); $i ++) {
                    $store_products = Cart::where('store_id', $unrepeated_stores[$i])->where('visitor_id', $visitor_id)->get();
                    
                    $pluck_products = Cart::where('store_id', $unrepeated_stores[$i])->pluck('product_id')->toArray();
                    if (count($store_products) > 0) {
                        $subtotal_price = 0;
                        for ($n = 0; $n < count($store_products); $n ++) {
                            if($store_products[$n]->product->remaining_quantity < $cart[$n]['count']){
                                $d_main_order = MainOrder::find($main_order['id']);
                                $d_main_order->delete();
                                $response = APIHelpers::createApiResponse(true , 406 , 'The remaining amount of the product is not enough' , 'الكميه المتبقيه من المنتج غير كافيه'  , null , $request->lang);
                                return response()->json($response , 406);
                            }
                            $single_product = Product::select('id', 'remaining_quantity')->where('id', $store_products[$n]['product_id'])->first();
                            $single_product->remaining_quantity = $single_product->remaining_quantity - $store_products[$n]['count'];
                            $single_product->save();
                            $subtotal_price = $subtotal_price + ($store_products[$n]->product->final_price * $store_products[$n]['count']);
                            
                        }
                    }
    
                    $shop = Shop::where('id', $unrepeated_stores[$i])->select('min_order_cost', 'name')->first();
                    if ($subtotal_price < $shop['min_order_cost']) {
                        $d_main_order = MainOrder::find($main_order['id']);
                        $d_main_order->delete();
                        $response = APIHelpers::createApiResponse(true , 406 , 'Minimum Order Cost for Store ' . $shop['name'] . ' is ' . $shop['min_order_cost'] . ' KWD' , 'الحد الأدنى لقيمة الطلب من متجر ' . $shop['name'] . ' هو ' . $shop['min_order_cost'] . ' د.ك'  , null , $request->lang);
                        return response()->json($response , 406);
                    }
                    
                    $delivery = DeliveryArea::select('delivery_cost')->where('area_id', $address['area_id'])->where('store_id', $unrepeated_stores[$i])->first();
                    if (!isset($delivery['delivery_cost'])) {
                        $delivery = Setting::find(1);
                    }
                    $total_cost = $delivery['delivery_cost'] + $subtotal_price;
                    $total_price = $total_price + $total_cost;
                    
                    $order = Order::create([
                            'user_id' => auth()->user()->id,
                            'address_id' => $request->address_id,
                            'payment_method' => $request->payment_method,
                            'subtotal_price' => number_format((float)$subtotal_price, 3, '.', ''),
                            'delivery_cost' => number_format((float)$delivery['delivery_cost'], 3, '.', ''),
                            'total_price' => number_format((float)$total_cost, 3, '.', ''),
                            'order_number' => substr(str_shuffle(uniqid() . $str) , -9),
                            'store_id' => $unrepeated_stores[$i],
                            'main_id' => $main_order['id']
                        ]);
                    $count = 0;
                    for($k = 0; $k < count($store_products); $k++){
                        
                        $product_data = Product::select('final_price', 'price_before_offer')->where('id', $store_products[$k]['product_id'])->first();
                        
                        $order_item =  OrderItem::create([
                            'order_id' => $order->id,
                            'product_id' => $store_products[$k]['product_id'],
                            'price_before_offer' => number_format((float)$product_data['price_before_offer'], 3, '.', ''),
                            'final_price' => number_format((float)$product_data['final_price'], 3, '.', ''),
                            'count' => $store_products[$k]['count']
                        ]);
                        
                        $count = $count + $store_products[$k]['count'];
                                              
                    }
                    array_push($ordersIds, $order['id']);
                    
                }
            }
            $u_main_order = MainOrder::find($main_order['id']);
            $user = auth()->user();
            $wallet = Wallet::where('user_id', $user->id)->first();
            if (!isset($wallet['id']) || $wallet['balance'] < $total_price) {
                for ($p = 0; $p < count($u_main_order->orders); $p ++) {
                    $u_main_order->orders[$p]->delete();
                }
                $u_main_order->delete();
                $response = APIHelpers::createApiResponse(true , 406 , 'Not Enough wallet balance' , 'رصيد المحفظة لا يكفى' , null , $request->lang);
                return response()->json($response , 406);
            }else {
                for ($p = 0; $p < count($cart); $p++) {
                    $cart[$p]->delete();
                }
                $toPrice = number_format((float)$total_price, 3, '.', '');
                $wallet['balance'] = $wallet['balance'] - $toPrice;
                $wallet->save();
            }
            $subTPrice = number_format((float)$main_order->orders->sum('subtotal_price'), 3, '.', '');
            $dCost = number_format((float)$main_order->orders->sum('delivery_cost'), 3, '.', '');
            $tPrice = number_format((float)$main_order->orders->sum('total_price'), 3, '.', '');
            $u_main_order->update([
                'subtotal_price' => $subTPrice,
                'delivery_cost' => $dCost,
                'total_price' => $tPrice
            ]);

            $data = [
                'main_order_number' => $u_main_order['main_order_number'],
                'count' => $count,
                'date' => $u_main_order['created_at']->format('Y-m-d'),
                'time' => $u_main_order['created_at']->format('g:i A'),
                'total_cost' => number_format((float)$main_order->orders->sum('total_price'), 3, '.', '')
            ];

            for ($p =0; $p < count($ordersIds); $p ++) {
                $recentOrder = Order::find($ordersIds[$p]);
                $notification = new StoreNotification();
                $notification->title = $notificationTitle;
                $notification->body = $notificationBody;
                $notification->store_id = $recentOrder->store->id;
                $notification->save();
                $notificationss = APIHelpers::send_notification_store($notification->title , $notification->body , null , $recentOrder , [$recentOrder->store->fcm_token]);  
            }
        }
        $response = APIHelpers::createApiResponse(false , 200 ,  '' , '' , $data , $request->lang );
        return response()->json($response , 200); 
    }

    public function excute_pay(Request $request){
        $user = User::find($request->user_id);
        $user_id = $user->id;
        $visitor  = Visitor::where('unique_id' , $request->unique_id)->first();
        $user_id_unique_id = $visitor->user_id;
        $visitor_id = $visitor->id;
        $cart = Cart::where('visitor_id' , $visitor_id)->get();

        $str = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $main_order_number = substr(str_shuffle(uniqid() . $str) , -9);
        $address = UserAddress::select('area_id')->find($request->address_id);
        $stores = Shop::join('products', 'products.store_id', '=', 'shops.id')
            ->where('carts.visitor_id', $visitor_id)
            ->leftjoin('carts', function($join) {
                $join->on('carts.product_id', '=', 'products.id');
            })
            ->pluck('shops.id')
            ->toArray();
        $unrepeated_stores1 = array_unique($stores);
        $unrepeated_stores = [];
        foreach ($unrepeated_stores1 as $key => $value) {
			array_push($unrepeated_stores, $value); 
		}
        $main_order = MainOrder::create([
            'user_id' => $request->user_id,
            'address_id' => $request->address_id,
            'payment_method' => $request->payment_method,
            'main_order_number' => $main_order_number
        ]);

        if ($request->lang == 'en') {
            $notificationTitle = "New order";
            $notificationBody = "a user has made a new order from you";
        }else {
            $notificationTitle = "طلب جديد";
            $notificationBody = "قام مستخدم بطلب جديد منك";
        }
        if (count($stores) > 0) {
            for ($i = 0; $i < count($unrepeated_stores); $i ++) {
                $store_products = Cart::where('store_id', $unrepeated_stores[$i])->where('visitor_id', $visitor_id)->get();
                
                $pluck_products = Cart::where('store_id', $unrepeated_stores[$i])->pluck('product_id')->toArray();
                if (count($store_products) > 0) {
                    $subtotal_price = 0;
                    for ($n = 0; $n < count($store_products); $n ++) {
                        if($store_products[$n]->product->remaining_quantity < $cart[$n]['count']){
                            $d_main_order = MainOrder::find($main_order['id']);
                            $d_main_order->delete();
                            $response = APIHelpers::createApiResponse(true , 406 , 'The remaining amount of the product is not enough' , 'الكميه المتبقيه من المنتج غير كافيه'  , null , $request->lang);
                            return response()->json($response , 406);
                        }
                        $single_product = Product::select('id', 'remaining_quantity')->where('id', $store_products[$n]['product_id'])->first();
                        $single_product->remaining_quantity = $single_product->remaining_quantity - $store_products[$n]['count'];
                        $single_product->sold_count = $single_product->sold_count + $store_products[$n]['count'];
                        $single_product->save();
                        if ($store_products[$n]['option_id'] != 0) {
                            $m_option = ProductMultiOption::find($store_products[$n]['option_id']);
                            $subtotal_price = $subtotal_price + ($m_option['final_price'] * $store_products[$n]['count']);
                            $m_option->remaining_quantity = $m_option->remaining_quantity - $store_products[$n]['count'];
                        }else {
                            $subtotal_price = $subtotal_price + ($store_products[$n]->product->final_price * $store_products[$n]['count']);
                        }
                    }
                }

                
                $delivery = DeliveryArea::select('delivery_cost')->where('area_id', $address['area_id'])->where('store_id', $unrepeated_stores[$i])->first();
                if (!isset($delivery['delivery_cost'])) {
                    $delivery = Setting::find(1);
                }
                $total_cost = $delivery['delivery_cost'] + $subtotal_price;
                
                $order = Order::create([
                        'user_id' => $request->user_id,
                        'address_id' => $request->address_id,
                        'payment_method' => $request->payment_method,
                        'subtotal_price' => number_format((float)$subtotal_price, 3, '.', ''),
                        'delivery_cost' => number_format((float)$delivery['delivery_cost'], 3, '.', ''),
                        'total_price' => number_format((float)$total_cost, 3, '.', ''),
                        'order_number' => substr(str_shuffle(uniqid() . $str) , -9),
                        'store_id' => $unrepeated_stores[$i],
                        'main_id' => $main_order['id']
                    ]);

                $count = 0;
                for($k = 0; $k < count($store_products); $k++){
                    
                    $product_data = Product::select('final_price', 'price_before_offer')->where('id', $store_products[$k]['product_id'])->first();
                    
                    $order_item =  OrderItem::create([
                        'order_id' => $order->id,
                        'product_id' => $store_products[$k]['product_id'],
                        'price_before_offer' => number_format((float)$product_data['price_before_offer'], 3, '.', ''),
                        'final_price' => number_format((float)$product_data['final_price'], 3, '.', ''),
                        'count' => $store_products[$k]['count']
                    ]);
                    
                    $count = $count + $store_products[$k]['count'];
                    $cartItem = Cart::find($store_products[$k]['id']);
                    $cartItem->delete();                       
                }

                
                $notification = new StoreNotification();
                $notification->title = $notificationTitle;
                $notification->body = $notificationBody;
                $notification->store_id = $order->store->id;
                $notification->save();
                $notificationss = APIHelpers::send_notification_store($notification->title , $notification->body , null , $order , [$order->store->fcm_token]);  
            }
        }
        $u_main_order = MainOrder::find($main_order['id']);
        $subTPrice = number_format((float)$main_order->orders->sum('subtotal_price'), 3, '.', '');
        $dCost = number_format((float)$main_order->orders->sum('delivery_cost'), 3, '.', '');
        $tPrice = number_format((float)$main_order->orders->sum('total_price'), 3, '.', '');
        $u_main_order->update([
            'subtotal_price' => $subTPrice,
            'delivery_cost' => $dCost,
            'total_price' => $tPrice
        ]);

        $date = $u_main_order['created_at']->format('Y-m-d');
        $time = $u_main_order['created_at']->format('g:i A');
        $total_cost = number_format((float)$main_order->orders->sum('total_price'), 3, '.', '');
                

        return redirect('api/pay/success?order_id=' . $u_main_order->id . '&main_order_number=' . $u_main_order['main_order_number'] . '&count=' . $count . '&date=' . $date . '&time=' . $time . '&total_cost=' . $total_cost); 
    }

    public function getorders(Request $request){
        $user_id = auth()->user()->id;
        $orders = MainOrder::where('user_id' , $user_id)->select('id' , 'total_price' , 'main_order_number' , 'created_at', 'status')->orderBy('id' , 'desc')->get();
        for($i = 0; $i < count($orders); $i++){
            
            $items = OrderItem::join('orders','orders.id', '=','order_items.order_id')
            ->where('main_orders.id', $orders[$i]['id'])
            ->leftjoin('main_orders', function($join) {
                $join->on('main_orders.id', '=', 'orders.main_id');
            })
            ->select(DB::raw('SUM(order_items.count) as cnt'), 'order_items.product_id as pId')
            ->groupBy('order_items.count')
            ->groupBy('order_items.product_id')
            ->get();
            $orders[$i]['count'] = $items->sum('cnt');
            $date = date_create($orders[$i]['date']);
            $orders[$i]['date'] = $orders[$i]['created_at']->format('Y-m-d'); 
            $orders[$i]['time'] = $orders[$i]['created_at']->format('g:i A');
        }
        
        
        
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $orders , $request->lang);
        return response()->json($response , 200);
    }

    public function pay_sucess(){
        return "Please wait ...";
    }

    public function pay_error(){
        return "Please wait ...";
    }
    
    public function orderdetails(Request $request){
        $order_id = $request->id;
        $order = MainOrder::select('id', 'payment_method', 'subtotal_price', 'delivery_cost', 'total_price', 'main_order_number', 'address_id', 'created_at')->where('id', $order_id)->first()->makeHidden(['address_id', 'orders_with_select', 'created_at']);
        $order['date'] = $order['created_at']->format('Y-m-d');
        $address = UserAddress::find($order['address_id'])->makeHidden(['area_id', 'area_with_select', 'created_at', 'updated_at']);
        $data['order'] = $order;
        // dd($order);
        $stores = $order->orders_with_select->makeHidden(['store', 'oItems']);
        
        if (count($stores) > 0) {
            for ($i = 0; $i < count($stores); $i ++) {
                $stores[$i]['store_name'] = $stores[$i]->store->name;
                $stores[$i]['store_logo'] = $stores[$i]->store->logo;
                $address = UserAddress::where('id', $order['address_id'])->first();
                $deliveryArea = DeliveryArea::where('area_id', $address['area_id'])->where('store_id', $stores[$i]->store->id)->first();
                if (!$deliveryArea) {
                    $deliveryArea['estimated_arrival_time'] = "0";
                }
                $stores[$i]['estimated_arrival_time'] = $deliveryArea['estimated_arrival_time'];
                
                $products = [];
                if (count($stores[$i]->oItems) > 0) {
                    for ($n = 0; $n < count($stores[$i]->oItems); $n ++) {
                        $stores[$i]['date'] = $stores[$i]['created_at']->format('d-m-y');
                        $stores[$i]->oItems[$n]['product'] = $stores[$i]->oItems[$n]->product_with_select->makeHidden(['mainImage', 'multi_options']);
                        $stores[$i]->oItems[$n]['product']['count'] = $stores[$i]->oItems[$n]['count'];
                        $stores[$i]->oItems[$n]['product']['status'] = $stores[$i]->oItems[$n]['status'];
                        $stores[$i]->oItems[$n]['product']['image'] = $stores[$i]->oItems[$n]->product_with_select->mainImage['image'];
                        $stores[$i]->oItems[$n]['product']['item_id'] = $stores[$i]->oItems[$n]['id'];
                        $stores[$i]->oItems[$n]['product']['store_name'] = $stores[$i]->store->name;
                        $passed = OrderItem::where('created_at', '>=', Carbon::now()->subDays(14)->toDateTimeString())->where('id', $stores[$i]->oItems[$n]['id'])->first();
                        $stores[$i]->oItems[$n]['product']['show_refund_button'] = true;
                        if (! isset($passed['id'])) {
                            $stores[$i]->oItems[$n]['product']['show_refund_button'] = false;
                        }
                        array_push($products, $stores[$i]->oItems[$n]->product_with_select);
                    }
                }
                $stores[$i]['products'] = $products;
            }
        }



        $data['stores'] = $stores;

        
        if($address){
            $address['area'] = $address->area_with_select['title'];
            $data['address'] = $address;
        }else{
            $data['address'] = new \stdClass();
        }
        
        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , $data , $request->lang);
        return response()->json($response , 200);
    }

    public function cancel_item(Request $request, OrderItem $item) {
        if ($item->status != 1) {
            $response = APIHelpers::createApiResponse(true , 406 , 'cant cancel this item' , 'لا يمكن الغاء هذا العنصر' , null , $request->lang);
            return response()->json($response , 406);
        }
        $dcost = $item->order['delivery_cost'];
        
        $item->update([
            'status' => 4,// canceled
            'final_price' => '0.000',
            'price_before_offer' => '0.000'
        ]);

        $item->product->remaining_quantity = $item->product->remaining_quantity + $item->count;
        $item->product->sold_count = $item->product->sold_count - $item->count;
        $item->product->save();
        
        $orderStatus = $item->order->status;
        $dSubCostT = $item->order['delivery_cost'];
        $dSubCost = 0;
        
        if (count($item->order->canceledItems) == count($item->order->oItems)) {
            $orderStatus = 4;
            $dSubCost = $item->order->delivery_cost;
            $totalP = '0.000';
        }else {
            $totalP = $item->order->oItems->sum('final_price') + $item->order->delivery_cost;
        }
        $dMainC = $item->order->main->delivery_cost - $dSubCost;
        $item->order->main->update(['delivery_cost' => number_format((float)$dMainC, 3, '.', '')]);
        // dd(count($item->order->oItems));
        $subTP = $item->order->oItems->sum('final_price');
        $subTP = number_format((float)$subTP, 3, '.', '');
        $totalP = number_format((float)$totalP, 3, '.', '');
        $convertedDSub = $item->order->delivery_cost - $dSubCost;
        $convertedDSub = number_format((float)$convertedDSub, 3, '.', '');
        
        $item->order->update([
            'subtotal_price' => $subTP,
            'total_price' => $totalP,
            'delivery_cost' => $convertedDSub,
            'status' => $orderStatus
        ]);
        
        $cancelStatus = $item->order->main->status;
        $dMainCost = 0;
        if (count($item->order->main->canceledOrders) == count($item->order->main->orders)) {
            $cancelStatus = 4;
            $dMainCost = $item->order->main->delivery_cost;
        }
        $subTotal = $item->order->main->orders->sum('subtotal_price');
        $subTotal = number_format((float)$subTotal, 3, '.', '');
        $totalPrice = $item->order->main->orders->sum('total_price');
        $totalPrice = number_format((float)$totalPrice, 3, '.', '');
        
        // dd($convertedMain);
        $item->order->main->update([
            'subtotal_price' => $subTotal,
            'total_price' => $totalPrice,
            'status' => $cancelStatus
        ]);
        

        if ($item->order->main['payment_method'] == 3 || $item->order->main['payment_method'] == 1) {
            $walletUser = Wallet::where('user_id', $item->order->main['user_id'])->first();
            
            if (count($item->order->canceledItems) != count($item->order->oItems)) {
                $dcost = 0;
            }
            
            if ($walletUser) {
                $walletUser['balance'] = $walletUser['balance'] + ($item['count'] * $item->product['final_price']) + $dcost;
                $walletUser->save();
            }else {
                Wallet::create([
                    'user_id' => $item->order->main['user_id'],
                    'balance' => ($item['count'] * $item->product['final_price']) + $dcost
                ]);
            }
        }
        

        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , '' , $request->lang);
        return response()->json($response , 200);
    }

    public function retrieve_item(Request $request) {
        
        $validator = Validator::make($request->all(), [
            'item_id' => 'required',
            'reason' => 'required'
        ]);
        

        if ($validator->fails()) {
            $response = APIHelpers::createApiResponse(true , 406 , 'Missing Required Fields' , 'بعض الحقول مفقودة' , null , $request->lang);
            return response()->json($response , 406);
        }

        $item = OrderItem::select('id', 'status', 'product_id', 'order_id')->where('id', $request->item_id)->first();
        // dd($item);
        if ($item->status != 3) {
            $response = APIHelpers::createApiResponse(true , 406 , 'cant retrieve this item' , 'لا يمكن إسترجاع هذا العنصر' , null , $request->lang);
            return response()->json($response , 406);
        }
        $str = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
        $refund_number = substr(str_shuffle(uniqid() . $str) , -9);
        $post = $request->all();
        $post['user_id'] = auth()->user()->id;
        $post['store_id'] = $item->product->store_id;
        $post['refund_number'] = $refund_number;
        Retrieve::create($post);

        if ($request->lang == 'en') {
            $notificationTitle = "Refund Order";
            $notificationBody = auth()->user()->name . " wants to retrieve product";
        }else {
            $notificationTitle = "طلب إسترجاع";
            $notificationBody = auth()->user()->name . " يريد أن يسترجع منتج";
        }

        $notification = new StoreNotification();
        $notification->title = $notificationTitle;
        $notification->body = $notificationBody;
        $notification->store_id = $item->order->store->id;
        $notification->save();
        $order['order_id'] = $item->order->main->id;
        $notificationss = APIHelpers::send_notification_store($notification->title , $notification->body , null , $order , [$item->order->store->fcm_token]);
        
        $item->update(['status' => 5]);


        $response = APIHelpers::createApiResponse(false , 200 , '' , '' , '' , $request->lang);
        return response()->json($response , 200);
    }

}