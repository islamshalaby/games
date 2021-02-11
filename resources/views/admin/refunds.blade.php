@extends('admin.app')

@section('title' , __('messages.show_refund_requests'))

@section('content')
    <div id="tableSimple" class="col-lg-12 col-12 layout-spacing">
        <div class="statbox widget box box-shadow">
            <div class="widget-header">
            <div class="row">
                <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                    <h4>{{ __('messages.show_refund_requests') }}</h4>
                </div>
            </div>
        </div>
        <div class="widget-content widget-content-area">
            <div class="table-responsive"> 
                <table id="html5-extension" class="table table-hover non-hover" style="width:100%">
                    <thead>
                        <tr>
                            <th>Id</th>  
                            <th>{{ __('messages.refund_number') }}</th>  
                            <th>{{ __('messages.main_order_number') }}</th> 
                            <th>{{ __('messages.sub_order_number') }}</th> 
                            <th>{{ __('messages.user_name') }}</th>
                            <th>{{ __('messages.store') }}</th>
                            <th>{{ __('messages.date') }}</th>
                            <th class="text-center">{{ __('messages.details') }}</th>
                            <th class="text-center">{{ __('messages.seen?') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $i = 1; ?>
                        @foreach ($data['refunds'] as $item)
                            <tr class="{{$item->admin_seen == 0 ? 'unread' : '' }}" >
                                <td><?=$i;?></td>
                                <td>{{ $item->refund_number }}</td>
                                <td>{{ $item->item->order->order_number }}</td>
                                <td>{{ $item->item->order->main->main_order_number }}</td>
                                <td>{{ $item->user->name }}</td>
                                <td>{{ $item->store->name }}</td>
                                <td>{{ $item->created_at }}</td>
                                <td class="text-center blue-color"><a href="{{ route('refund.details', $item->id) }}" ><i class="far fa-eye"></i></a></td>
                                <td style="font-weight : bold" class="text-center blue-color" >
                                    {{ $item->admin_seen == 0 ?  __('messages.unseen')  :  __('messages.seen')  }}
                                </td>
                                
                                <?php $i++; ?>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
        {{-- <div class="paginating-container pagination-solid">
            <ul class="pagination">
                <li class="prev"><a href="{{$data['contact_us']->previousPageUrl()}}">Prev</a></li>
                @for($i = 1 ; $i <= $data['contact_us']->lastPage(); $i++ )
                    <li class="{{ $data['contact_us']->currentPage() == $i ? "active" : '' }}"><a href="/admin-panel/contact_us/?page={{$i}}">{{$i}}</a></li>               
                @endfor
                <li class="next"><a href="{{$data['contact_us']->nextPageUrl()}}">Next</a></li>
            </ul>
        </div>   --}}
        
    </div>  

@endsection