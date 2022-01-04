@extends('admin.app')

@section('title' , __('messages.ad_details'))

@section('content')
        <div id="tableSimple" class="col-lg-12 col-12 layout-spacing">
        <div class="statbox widget box box-shadow">
            <div class="widget-header">
            <div class="row">
                <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                    <h4>{{ __('messages.ad_details') }}</h4>
                </div>
            </div>
        </div>
        <div class="widget-content widget-content-area">
            <div class="table-responsive"> 
                <table class="table table-bordered mb-4">
                    <tbody>
                            <tr>
                                <td class="label-table" > {{ __('messages.image') }}</td>
                                <td>
                                    <img src="https://res.cloudinary.com/dezsm0sg7/image/upload/w_100,q_100/v1581928924/{{ $data['ad']['image'] }}"  />
                                </td>
                            </tr>
                            <tr>
                                <td class="label-table" > {{ __('messages.ad_type') }}</td>
                                <td>
                                    {{ $data['ad']['place'] == 1 ? __('messages.inside_slider') : __('messages.normal_ad') }}
                                </td>
                            </tr>
                            <tr>
                                <td class="label-table" > {{ __('messages.ad_place') }}</td>
                                <td>
                                    {{ $data['ad']['type'] == 2 ? __('messages.outside_the_app') : __('messages.inside_the_app') }}
                                </td>
                            </tr>
                            @if ($data['ad']['type'] == 2)
                            <tr>
                                <td class="label-table" > {{ __('messages.link') }} </td>
                                <td>
                                    <a target="_blank" href="{{ $data['ad']['content'] }}" >
                                        {{ $data['ad']['content'] }}
                                    </a>
                                </td>
                            </tr>    
                            @else
                                @if ($data['ad']['content_type'] == 1)
                                <tr>
                                    <td class="label-table" > {{ __('messages.product') }} </td>
                                    <td>
                                        {{ App::isLocale('en') && isset($data['product']['id']) ? $data['product']['title_en'] : $data['product']['title_ar'] }}
                                    </td>
                                </tr> 
                                @endif
                                @if ($data['ad']['content_type'] == 2)
                                <tr>
                                    <td class="label-table" > {{ __('messages.store') }} </td>
                                    <td>
                                        {{ $data['ad']->storeCat->name }}
                                    </td>
                                </tr> 
                                <tr>
                                    <td class="label-table" > {{ __('messages.category') }} </td>
                                    <td>
                                        {{ App::isLocale('en') && isset($data['category']['id']) ? $data['category']['title_en'] : $data['category']['title_ar'] }}
                                    </td>
                                </tr> 
                                @endif
                                @if ($data['ad']['content_type'] == 3)
                                <tr>
                                    <td class="label-table" > {{ __('messages.store') }} </td>
                                    <td>
                                        {{ isset($data['store']['id']) ? $data['store']['name'] : '' }}
                                    </td>
                                </tr> 
                                @endif
                            @endif
                    </tbody>
                </table>
            </div>
        </div>
    </div>  
    
@endsection