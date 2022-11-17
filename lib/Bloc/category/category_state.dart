import 'package:meta/meta.dart';

import '../../Model/category_list.dart';
import '../../Model/category_product_model.dart';
import '../../Model/product_model.dart';


@immutable
abstract class ProductState {}


class InitialProductListState extends ProductState {}


class ProductLoading extends ProductState {}

class ProductListLoadFail extends ProductState {}

class ProductListSuccess extends ProductState {
 List<CategoryModel>? productList;
  ProductListSuccess({this.productList});
}


class CategoryProductLoading extends ProductState {}



class CategoryProductSuccess extends ProductState {
 List<ProductModel>? categoryProductList;
 CategoryProductSuccess({this.categoryProductList});
}

class CategoryProductFail extends ProductState {}


