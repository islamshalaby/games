<?php
namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Admin\AdminController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\MainOrder;
use App\MultiOption;
use App\OrderItem;
use App\Area;
use App\Order;
use App\UserAddress;
use App\SizeDetail;


class OrderController extends AdminController{
    // get all orders
    public function show(Request $request){
        $data['orders'] = MainOrder::orderBy('id' , 'desc')->get();
        $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
        $data['sum_price'] = MainOrder::sum('subtotal_price');
        $data['sum_delivery'] = MainOrder::sum('delivery_cost');
        $data['sum_total'] = MainOrder::sum('total_price');
        
        return view('admin.orders' , ['data' => $data]);
    }

    // cancel | delivered order
    public function action_order(MainOrder $order, $status) {
        $order->update(['status' => $status]);
        for ($i = 0; $i < count($order->orders); $i ++) {
            if ($status == 2) {
                if ($order->orders[$i]['status'] == 1) {
                    $order->orders[$i]->update(['status' => 2]);
                }
            }
        }

        return redirect()->back();
    }


    // action sub order
    public function action_sub_order(Request $request, Order $order) {
        $order->update(['status' => $request->status]);

        for ($i = 0; $i < count($order->oItems); $i ++) {
            $order->oItems[$i]->update(['status' => $request->status]);
        }

        return redirect()->back();
    }

    

    // details
    public function details(MainOrder $order) {
        $data['order'] = $order;
        $data['m_option'] = MultiOption::find(8);

        return view('admin.order_details', ['data' => $data]);
    }

    // order items actions
    public function order_items_actions(Request $request, OrderItem $item) {
        $item->update(['status' => $request->status]);
        $order_inprogress = 0;
        $order_delivered = 0;
        $main_order_inprogress = 0;
        $main_order_delivered = 0;
        // $status_array = [];
        
        for ($i = 0; $i < count($item->order->oItems); $i ++) {
            if(in_array($request->status, [1, 2])) {
                if ( in_array($item->order->oItems[$i]->status, [1, 2]) ) {
                    $order_inprogress ++;
                }
            }else if($request->status == 3) {
                if ( in_array($item->order->oItems[$i]->status, [3, 4, 7]) ) {
                    $order_delivered ++;
                }
            }

            // array_push($status_array, $item->order->oItems[$i]->status);
        }

        

        if ($order_inprogress == count($item->order->oItems)) {
            $item->order->update(['status' => 1]);
        }
        
        if ($order_delivered == count($item->order->oItems)) {
            $item->order->update(['status' => 3]);
        }

        for ($n =0; $n < count($item->order->main->orders); $n ++) {
            if(in_array($request->status, [1])) {
                if ( in_array($item->order->main->orders[$n]->status, [1]) ) {
                    $main_order_inprogress ++;
                }
            }else if($request->status == 3) {
                if ( in_array($item->order->main->orders[$n]->status, [3, 4, 7]) ) {
                    $main_order_delivered ++;
                }
            }
        }

        if ($order_inprogress == count($item->order->main->orders)) {
            $item->order->main->update(['status' => 1]);
        }
        
        if ($order_delivered == count($item->order->main->orders)) {
            $item->order->main->update(['status' => 3]);
        }

        return redirect()->back();
    }

    public function order_actions(Request $request, Order $item) {
        $order_inprogress = 0;
        $order_delivered = 0;
        $main_order_inprogress = 0;
        $main_order_delivered = 0;
        $item->update(['status' => $request->status]);
        // dd($item);
        
        for ($i = 0; $i < count($item->oItems); $i ++) {
            $item->oItems[$i]->status = $request->status;
            $item->oItems[$i]->save();
            if(in_array($request->status, [1, 2])) {
                if ( in_array($item->oItems[$i]->status, [1, 2]) ) {
                    $order_inprogress ++;
                }
            }else if($request->status == 3) {
                if ( in_array($item->oItems[$i]->status, [3, 4, 7]) ) {
                    $order_delivered ++;
                }
            }

            // array_push($status_array, $item->order->oItems[$i]->status);
        }

        

        // if ($order_inprogress == count($item->oItems)) {
        //     $item->update(['status' => 1]);
        // }
        
        // if ($order_delivered == count($item->oItems)) {
        //     $item->update(['status' => 3]);
        // }

        for ($n =0; $n < count($item->main->orders); $n ++) {
            if(in_array($request->status, [1, 2])) {
                if ( in_array($item->main->orders[$n]->status, [1, 2]) ) {
                    $main_order_inprogress ++;
                }
            }else if($request->status == 3) {
                if ( in_array($item->main->orders[$n]->status, [3, 4, 7]) ) {
                    $main_order_delivered ++;
                }
            }
        }

        if ($order_inprogress == count($item->main->orders)) {
            $item->main->update(['status' => 1]);
        }
        
        if ($order_delivered == count($item->main->orders)) {
            $item->main->update(['status' => 3]);
        }

        return redirect()->back();
    }

    // filter orders
    public function filter_orders(Request $request, $status) {
        if (isset($request->area_id)) {
            $addresses = UserAddress::with('orders')->where('area_id', $request->area_id)->get();
            $data['sum_price'] = 0;
            $data['sum_delivery'] = 0;
            $data['sum_total'] = 0;
            $orders = [];
            if (count($addresses) > 0) {
                foreach ($addresses as $address) {
                    if (count($address->orders) > 0) {
                        foreach($address->orders as $order) {
                            if ($order->status == $status) {
                                $data['sum_price'] += $order->subtotal_price;
                                $data['sum_delivery'] += $order->delivery_cost;
                                $data['sum_total'] += $order->total_price;
                                array_push($orders, $order);
                            }
                        }
                    }
                }
            }
            $data['orders'] = $orders;
            $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
            $data['area'] = Area::findOrFail($request->area_id);
        }elseif(isset($request->from)) {
            $data['orders'] = MainOrder::where('status', $status)->whereBetween('created_at', array($request->from, $request->to))->get();
            $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
            $data['sum_price'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->sum('subtotal_price');
            $data['sum_delivery'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->sum('delivery_cost');
            $data['sum_total'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->sum('total_price');
        }else if(isset($request->method)) {
            $data['orders'] = MainOrder::where('status', $status)->where('payment_method', $request->method)->get();
            $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
            $data['sum_price'] = MainOrder::where('status', $status)->where('payment_method', $request->method)->sum('subtotal_price');
            $data['sum_delivery'] = MainOrder::where('status', $status)->where('payment_method', $request->method)->sum('delivery_cost');
            $data['sum_total'] = MainOrder::where('status', $status)->where('payment_method', $request->method)->sum('total_price');
            $data['method'] = $request->method;
        }else if(isset($request->sub_number)) {
            $data['orders'] = MainOrder::where('status', $status)->whereHas('orders', function($q) use($request) {
                $q->where('order_number', 'like','%' . $request->sub_number . '%');
            })->get();
            $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
            $data['sum_price'] = MainOrder::where('status', $status)->whereHas('orders', function($q) use($request) {
                $q->where('order_number', 'like','%' . $request->sub_number . '%');
            })->sum('subtotal_price');
            $data['sum_delivery'] = MainOrder::where('status', $status)->whereHas('orders', function($q) use($request) {
                $q->where('order_number', 'like','%' . $request->sub_number . '%');
            })->sum('delivery_cost');
            $data['sum_total'] = MainOrder::where('status', $status)->whereHas('orders', function($q) use($request) {
                $q->where('order_number', 'like','%' . $request->sub_number . '%');
            })->sum('total_price');
        }else {
            $data['orders'] = MainOrder::where('status', $status)->get();
            $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
            $data['sum_price'] = MainOrder::where('status', $status)->sum('subtotal_price');
            $data['sum_delivery'] = MainOrder::where('status', $status)->sum('delivery_cost');
            $data['sum_total'] = MainOrder::where('status', $status)->sum('total_price');
        }
        

        return view('admin.orders' , ['data' => $data]);
    }

    // fetch orders by area
    public function fetch_orders_by_area(Request $request) {
        $addresses = UserAddress::with('orders')->where('area_id', $request->area_id)->get();
        
        $orders = [];
        $data['sum_price'] = 0;
        $data['sum_delivery'] = 0;
        $data['sum_total'] = 0;
        if (count($addresses) > 0) {
            foreach ($addresses as $address) {
                if (count($address->orders) > 0) {
                    foreach($address->orders as $order) {
                        $data['sum_price'] += $order->subtotal_price;
                        $data['sum_delivery'] += $order->delivery_cost;
                        $data['sum_total'] += $order->total_price;
                        array_push($orders, $order);
                    }
                }
            }
        }
        $data['orders'] = $orders;
        $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
        $data['area'] = Area::findOrFail($request->area_id);
        return view('admin.orders' , ['data' => $data]);
    }

    // fetch order date range
    public function fetch_orders_date(Request $request) {
        $data['orders'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->get();
        $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
        $data['from'] = '';
        $data['to'] = '';
        if (isset($request->from)) {
            $data['from'] = $request->from;
            $data['to'] = $request->to;
        }
        $data['sum_price'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->sum('subtotal_price');
        $data['sum_delivery'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->sum('delivery_cost');
        $data['sum_total'] = MainOrder::whereBetween('created_at', array($request->from, $request->to))->sum('total_price');
        return view('admin.orders' , ['data' => $data]);
    }

    // fetch order payment method
    public function fetch_order_payment_method(Request $request) {
        $data['orders'] = MainOrder::where('payment_method', $request->method)->get();
        $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
        $data['sum_price'] = MainOrder::where('payment_method', $request->method)->sum('subtotal_price');
        $data['sum_delivery'] = MainOrder::where('payment_method', $request->method)->sum('delivery_cost');
        $data['sum_total'] = MainOrder::where('payment_method', $request->method)->sum('total_price');
        $data['method'] = $request->method;

        return view('admin.orders' , ['data' => $data]);
    }

    // fetch order by sub sorder number
    public function fetch_order_by_sub_order_number(Request $request) {
        $data['orders'] = MainOrder::whereHas('orders', function($q) use($request) {
            $q->where('order_number', 'like','%' . $request->sub_number . '%');
        })->get();
        $data['areas'] = Area::where('deleted', 0)->orderBy('id', 'desc')->get();
        $data['sum_price'] = MainOrder::whereHas('orders', function($q) use($request) {
            $q->where('order_number', 'like','%' . $request->sub_number . '%');
        })->sum('subtotal_price');
        $data['sum_delivery'] = MainOrder::whereHas('orders', function($q) use($request) {
            $q->where('order_number', 'like','%' . $request->sub_number . '%');
        })->sum('delivery_cost');
        $data['sum_total'] = MainOrder::whereHas('orders', function($q) use($request) {
            $q->where('order_number', 'like','%' . $request->sub_number . '%');
        })->sum('total_price');

        return view('admin.orders' , ['data' => $data]);
    }

    // get invoice
    public function getInvoice(MainOrder $order) {
        $data['order'] = $order;

        return view('admin.invoice', ['data' => $data]);
    }

    // order size details
    public function order_size_details(OrderItem $item) {
        $data['size'] = $item->size;

        return view('admin.size_details', ['data' => $data]);
    }
}