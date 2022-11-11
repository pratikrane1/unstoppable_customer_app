import 'package:meta/meta.dart';

import '../../Model/category_list.dart';


@immutable
abstract class ProductState {}


class InitialProductListState extends ProductState {}


class ProductLoading extends ProductState {}

class DeleteProductLoading extends ProductState {}


class ProductListSuccess extends ProductState {
 List<CategoryModel>? productList;
  ProductListSuccess({this.productList});
}

class ProductListLoadFail extends ProductState {}



class DeleteProductSuccess extends ProductState {
 DeleteProductSuccess();
}



