@extends('admin.app')

@section('title' , __('messages.add_by_governorates') )

@section('content')
    <div class="col-lg-12 col-12 layout-spacing">
        <div class="statbox widget box box-shadow">
            <div class="widget-header">
                <div class="row">
                    <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                        <h4>{{ __('messages.add_by_governorates') }}</h4>
                 </div>
        </div>
        <form action="" method="post" enctype="multipart/form-data" >
            @csrf
            <div class="form-group mb-4">
                <label for="delivery_cost">{{ __('messages.delivery_cost') }}</label>
                <input required type="number" step="any" min="0" name="delivery_cost" class="form-control" id="delivery_cost" placeholder="{{ __('messages.delivery_cost') }}" value="" >
            </div>
            {{-- <div class="form-group mb-4">
                <label for="min_order_cost">{{ __('messages.min_order_cost') }}</label>
                <input required type="number" step="any" min="0" name="min_order_cost" class="form-control" id="min_order_cost" placeholder="{{ __('messages.min_order_cost') }}" >
            </div> --}}
            <div class="form-group mb-4">
                <label for="estimated_arrival_time">{{ __('messages.estimated_arrival_time') }} ( {{ __('messages.minutes') }} )</label>
                <input required type="number" step="any" min="0" name="estimated_arrival_time" class="form-control" id="estimated_arrival_time" placeholder="{{ __('messages.estimated_arrival_time') }}" >
            </div>
            <div class="form-group mb-4">
                <label for="area_id">{{ __('messages.governorate') }}</label>
                <select id="area_id" name="area_id" class="form-control">
                    <option disabled selected>{{ __('messages.select') }}</option>
                    @foreach ( $data['governorates'] as $governorate )
                    <option value="{{ $governorate->id }}">{{ App::isLocale("en") ? $governorate->title_en : $governorate->title_ar }}</option>
                    @endforeach
                </select>
            </div>
            <div style="display: none" class="form-group mb-4">
                <label for="store_id">{{ __('messages.store') }}</label>
                <select id="store_id" name="store_id" class="form-control">
                </select>
            </div>
            <input type="submit" value="{{ __('messages.submit') }}" class="btn btn-primary">
        </form>
    </div>
@endsection