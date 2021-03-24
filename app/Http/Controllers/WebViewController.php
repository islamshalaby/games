<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Setting;
use App\MainOrder;
use App\Order;
use Carbon\Carbon;
use PDF;
use App\OrderItem;
use App\Shop;

class WebViewController extends Controller
{
    // get about
    public function getabout(Request $request){
        $data['lang'] = $request->lang;
        $setting = Setting::find(1);
        if($data['lang'] == 'en' ){
            $data['text'] = $setting['aboutapp_en'];
        }else{
            $data['text'] = $setting['aboutapp_ar'];
        }
        return view('webview.about' , $data);
    }

    // get terms and conditions
    public function gettermsandconditions(Request $request){
        $data['lang'] = $request->lang;
        $setting = Setting::find(1);
        if($data['lang'] == 'en' ){
            $data['title'] = 'Terms and Conditions';
            $data['text'] = $setting['termsandconditions_en'];
        }else{
            $data['title'] = 'الشروط و الأحكام';
            $data['text'] = $setting['termsandconditions_ar'];
        }
        return view('webview.termsandconditions' , $data);
    }

    // returnpolicy
    public function returnpolicy(Request $request){

        $data['lang'] = $request->lang;
        $setting = Setting::find(1);
        if($data['lang'] == 'en' ){
            $data['title'] = 'Return Policy';
            $data['text'] = $setting['return_policy_en'];
        }else{
            $data['title'] = 'سياسه الإرجاع';
            $data['text'] = $setting['return_policy_ar'];
        }
        return view('webview.termsandconditions' , $data);

    }

    
        // returnpolicy
        public function deliveryinformation(Request $request){

            $data['lang'] = $request->lang;
            $setting = Setting::find(1);
            if($data['lang'] == 'en' ){
                $data['title'] = 'Delivery Information';
                $data['text'] = $setting['delivery_information_en'];
            }else{
                $data['title'] = 'معلومات التوصيل';
                $data['text'] = $setting['delivery_information_ar'];
            }
            return view('webview.termsandconditions' , $data);
    
        }
    
    // get invoice
    public function getInvoice(Request $request, MainOrder $order) {
        $data['order'] = $order;
        $data['setting'] = Setting::where('id', 1)->first();
        $pdf = PDF::loadView('admin.invoice_pdf', ['data' => $data]);
            
        return $pdf->stream('download.pdf');
    }

    // get store invoice
    public function getStoreInvoice(Request $request, Order $order) {
        $data['order'] = $order;
        $data['setting'] = Setting::where('id', 1)->first();
        $pdf = PDF::loadView('admin.invoice_store_pdf', ['data' => $data]);
            
        return $pdf->stream('download.pdf');
    }

    // get orders report
    public function getSalesReport(Request $request) {
        $data['shop'] = Shop::where('id', $request->id)->select('name', 'logo')->first();
        $data['orders'] = Order::where('store_id', $request->id)->orderBy('id' , 'desc')->get();
        $data['sum_subtotal'] = Order::where('store_id', $request->id)->sum('subtotal_price');
        $data['sum_subtotal'] = number_format((float)$data['sum_subtotal'], 3, '.', '');
        $data['sum_delivery_cost'] = Order::where('store_id', $request->id)->sum('delivery_cost');
        $data['sum_delivery_cost'] = number_format((float)$data['sum_delivery_cost'], 3, '.', '');
        $data['sum_total_price'] = Order::where('store_id', $request->id)->sum('total_price');
        $data['sum_total_price'] = number_format((float)$data['sum_total_price'], 3, '.', '');
        $data['today'] = Carbon::now()->format('d-m-Y');
        

        $data['setting'] = Setting::where('id', 1)->first();
        $pdf = PDF::loadView('admin.orders_report_pdf', ['data' => $data]);
            
        return $pdf->stream('download.pdf');
    }

    public function getSalesReportAdmin(Request $request) {
        $data['orders'] = Order::orderBy('id' , 'desc')->get();
        $data['sum_subtotal'] = Order::sum('subtotal_price');
        $data['sum_subtotal'] = number_format((float)$data['sum_subtotal'], 3, '.', '');
        $data['sum_delivery_cost'] = Order::sum('delivery_cost');
        $data['sum_delivery_cost'] = number_format((float)$data['sum_delivery_cost'], 3, '.', '');
        $data['sum_total_price'] = Order::sum('total_price');
        $data['sum_total_price'] = number_format((float)$data['sum_total_price'], 3, '.', '');
        $data['today'] = Carbon::now()->format('d-m-Y');
        

        $data['setting'] = Setting::where('id', 1)->first();
        $pdf = PDF::loadView('admin.orders_report_admin_pdf', ['data' => $data]);
            
        return $pdf->stream('download.pdf');
    }

    // get sales report
    public function getSalesReport2(Request $request) {
        $data['shop'] = Shop::where('id', $request->id)->select('name', 'logo')->first();
        $data['orders'] = OrderItem::join('orders', 'orders.id', '=', 'order_items.order_id')
        ->where('orders.store_id', $request->id)
        ->select('order_items.*')
        ->orderBy('id', 'desc')->get();
        $data['sum_total'] = 0;
        for ($i = 0; $i < count($data['orders']); $i ++) {
            $data['sum_total'] = $data['sum_total'] + ($data['orders'][$i]['final_price'] * $data['orders'][$i]['count']);
        }
        $data['sum_total'] = number_format((float)$data['sum_total'], 3, '.', '');
        $data['sum_final_price'] = OrderItem::join('orders', 'orders.id', '=', 'order_items.order_id')
        ->where('orders.store_id', $request->id)->sum('final_price');
        $data['sum_final_price'] = number_format((float)$data['sum_final_price'], 3, '.', '');
        $data['today'] = Carbon::now()->format('d-m-Y');
        

        $data['setting'] = Setting::where('id', 1)->first();
        $pdf = PDF::loadView('admin.sales_report_pdf', ['data' => $data]);
            
        return $pdf->stream('download.pdf');
    }

    // get sales report admin
    public function getSalesReport2Admin(Request $request) {
        $data['orders'] = OrderItem::join('orders', 'orders.id', '=', 'order_items.order_id')
        ->select('order_items.*')
        ->orderBy('id', 'desc')->get();
        $data['sum_total'] = 0;
        for ($i = 0; $i < count($data['orders']); $i ++) {
            $data['sum_total'] = $data['sum_total'] + ($data['orders'][$i]['final_price'] * $data['orders'][$i]['count']);
        }
        
        $data['sum_total'] = number_format((float)$data['sum_total'], 3, '.', '');
        $data['sum_final_price'] = $data['orders']->sum('final_price');
        $data['sum_final_price'] = number_format((float)$data['sum_final_price'], 3, '.', '');
        $data['today'] = Carbon::now()->format('d-m-Y');
        

        $data['setting'] = Setting::where('id', 1)->first();
        $pdf = PDF::loadView('admin.sales_report_admin_pdf', ['data' => $data]);
            
        return $pdf->stream('download.pdf');
    }

    public function test() {
        
        
        $geocode=file_get_contents('https://maps.googleapis.com/maps/api/geocode/json?latlng=29.1958852,48.0537201&sensor=true&key=AIzaSyCMSfq40Bo2KuQvQVSQE1gmmgJdxEbDS0Y&libraries');
        // dd($geocode);
        $output= json_decode($geocode);

        echo "<pre>";
        print_r($output);
        echo "</pre>";
    }

}
