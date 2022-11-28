import 'package:meta/meta.dart';

@immutable
abstract class MyOrdersEvent {}

class OnLoadingOrdersList extends MyOrdersEvent {
  String? userId;
  OnLoadingOrdersList({this.userId});
}
class GetProduct extends MyOrdersEvent{
  String sscatId;

  GetProduct({required this.sscatId});
}

class OnLoadingOrdersDetail extends MyOrdersEvent {
  String? orderId;
  OnLoadingOrdersDetail({this.orderId});
}
class CancelOrder extends MyOrdersEvent{
  String userId;
  String orderId;


  CancelOrder({required this.userId,required this.orderId});
}


//track order
class OnLoadingTrackOrderList extends MyOrdersEvent {
  String? orderId;
  OnLoadingTrackOrderList({this.orderId});
}




