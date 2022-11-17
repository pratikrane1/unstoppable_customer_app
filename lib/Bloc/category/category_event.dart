import 'package:meta/meta.dart';


@immutable
abstract class ProductEvent {}


class OnLoadingProductList extends ProductEvent {
  String perPage;
  String startFrom;
  OnLoadingProductList({required this.perPage, required this.startFrom});
}

class OnLoadingCategoryProductList extends ProductEvent{
  String ssCatId;


  OnLoadingCategoryProductList({required this.ssCatId});
}



