import 'package:meta/meta.dart';


@immutable
abstract class ProductEvent {}


class OnLoadingProductList extends ProductEvent {

  OnLoadingProductList();
}

class DeleteProduct extends ProductEvent{
  String productid;


  DeleteProduct({required this.productid});
}



class OnLoadingProductDetail extends ProductEvent {
  String prodId;
  OnLoadingProductDetail({required this.prodId});
}