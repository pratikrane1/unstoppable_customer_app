import 'package:meta/meta.dart';

import '../../Model/model_trackOrder.dart';
import '../../Model/my_order.dart';
import '../../Model/product_model.dart';

@immutable
abstract class MyOrdersState {}

class InitialOrdersListState extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}
class TrackOrdersLoading extends MyOrdersState {}
class OrdersDetailLoading extends MyOrdersState {}
class ProductLoading extends MyOrdersState {}
class CancelOrderLoading extends MyOrdersState {}


class MyOrdersListSuccess extends MyOrdersState {
  final List<Orders>? orderList;
  MyOrdersResp? orderData;
  MyOrdersListSuccess({this.orderList,this.orderData});
}

class ProductSuccess extends MyOrdersState {
  String message;
  List<ProductModel>? productData;
  ProductSuccess({required this.message, required this.productData});
}


class Productfail extends MyOrdersState {
  String message;
  Productfail({required this.message});
}
//for track order
class TrackOrdersListSuccess extends MyOrdersState {
  List<TrackData> trackOrderList;
  String? message;
  TrackOrdersListSuccess({required this.trackOrderList,this.message});
}


class MyOrdersListLoadFail extends MyOrdersState {}
class TrackOrdersListLoadFail extends MyOrdersState {
  String? message;
  TrackOrdersListLoadFail({this.message,});
}

class CancelOrderSuccess extends MyOrdersState {
  String? message;
  CancelOrderSuccess({this.message});
}
class CancelOrderFail extends MyOrdersState {
  String? message;

  CancelOrderFail({this.message});
}

class MyOrdersDetailLoading extends MyOrdersState {}



class MyOrdersDetailSuccess extends MyOrdersState {
  MyOrdersResp? data;
  final List<Orders>? orderList;
  MyOrdersDetailSuccess({this.data,this.orderList});
}

class MyOrdersDetailLoadFail extends MyOrdersState {}