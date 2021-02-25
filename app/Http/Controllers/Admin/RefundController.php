<?php
namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Admin\AdminController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Retrieve;
use App\Wallet;

class RefundController extends AdminController{

    // index
    public function show() {
        $data['refunds'] = Retrieve::get();
        
        return view('admin.refunds', ['data' => $data]);
    }

    // details
    public function details(Retrieve $refund) {
        $refund->update(['admin_seen' => 1]);
        $data['refund'] = $refund;

        return view('admin.refund_details', ['data' => $data]);
    }

    // accept refund
    public function accept(Retrieve $refund) {
        $refund->item->update(['status' => 6]);
        $order_status = 0;
        $main_order_cancel = 0;

        if ($refund->item->order->main['payment_method'] == 3 || $refund->item->order->main['payment_method'] == 1) {
            $walletUser = Wallet::where('user_id', $refund->item->order->main['user_id'])->first();
            if ($walletUser) {
                $walletUser['balance'] = $walletUser['balance'] + ($refund->item['count'] * $refund->item['final_price']);
                $walletUser->save();
            }else {
                Wallet::create([
                    'user_id' => $refund->item->order->main['user_id'],
                    'balance' => $refund->item['count'] * $refund->item['final_price']
                ]);
            }
        }

        for ($i = 0; $i < count($refund->item->order->oItems); $i ++) {
            if ( $refund->item->order->oItems[$i]->status == 6 ) {
                $order_status ++;
            }
        }

        if ($order_status == count($refund->item->order->oItems)) {
            $refund->item->order->update(['status' => 6]);
        }

        for ($n = 0; $n < count($refund->item->order->main->orders); $n ++) {
            if ($refund->item->order->main->orders[$n]->status == 6) {
                $main_order_cancel ++;
            }
        }

        if ($main_order_cancel == count($refund->item->order->main->orders)) {
            $refund->item->order->main->update(['status' => 4]);
        }

        return redirect()->back();
    }

    // reject refund
    public function reject(Retrieve $refund) {
        $refund->item->update(['status' => 7]);
        $order_status = 0;
        $main_order_cancel = 0;

        for ($i = 0; $i < count($refund->item->order->oItems); $i ++) {
            if ( $refund->item->order->oItems[$i]->status == 7 ) {
                $order_status ++;
            }
        }

        if ($order_status == count($refund->item->order->oItems)) {
            $refund->item->order->update(['status' => 7]);
        }

        for ($n = 0; $n < count($refund->item->order->main->orders); $n ++) {
            if ($refund->item->order->main->orders[$n]->status == 7) {
                $main_order_cancel ++;
            }
        }

        if ($main_order_cancel == count($refund->item->order->main->orders)) {
            $refund->item->order->main->update(['status' => 1]);
        }

        return redirect()->back();
    }

    // reveived refund
    public function received(Retrieve $refund) {
        $refund->item->update(['status' => 8, 'refunded_at' => date("Y-m-d H:i:s")]);
        $refund->item->product->remaining_quantity = $refund->item->product->remaining_quantity + $refund->item->count;
        $refund->item->product->refund_count = $refund->item->product->refund_count + $refund->item->count;
        $refund->item->product->save();

        $order_status = 0;
        $main_order_cancel = 0;

        for ($i = 0; $i < count($refund->item->order->oItems); $i ++) {
            if ( $refund->item->order->oItems[$i]->status == 8 ) {
                $order_status ++;
            }
        }

        if ($order_status == count($refund->item->order->oItems)) {
            $refund->item->order->update(['status' => 8]);
        }

        for ($n = 0; $n < count($refund->item->order->main->orders); $n ++) {
            if ($refund->item->order->main->orders[$n]->status == 4 || $refund->item->order->main->orders[$n]->status == 8) {
                $main_order_cancel ++;
            }
        }

        if ($main_order_cancel == count($refund->item->order->main->orders)) {
            $refund->item->order->main->update(['status' => 4]);
        }

        // $walletUser = Wallet::where('user_id', $refund->item->order->main['user_id'])->first();

        // if ($walletUser) {
        //     $walletUser['balance'] = $walletUser['balance'] + ($refund->item['count'] * $refund->item['final_price']);
        //     $walletUser->save();
        // }else {
        //     Wallet::create([
        //         'user_id' => $refund->item->order->main['user_id'],
        //         'balance' => $refund->item['count'] * $refund->item['final_price']
        //     ]);
        // }



        return redirect()->back();
    }
}