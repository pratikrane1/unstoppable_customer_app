import 'package:meta/meta.dart';

import '../../Model/category_list.dart';


@immutable
abstract class CategoryState {}


class InitialCategoryListState extends CategoryState {}


class CategoryLoading extends CategoryState {}

class DeleteCategoryLoading extends CategoryState {}


class CategoryListSuccess extends CategoryState {
 List<CategoryModel>? CategoryList;
 CategoryListSuccess({this.CategoryList});
}

class ProductListLoadFail extends ProductState {}

class CategoryProductLoading extends ProductState {}




class CategoryProductSuccess extends ProductState {
 List<ProductModel>? categoryProductList;

 CategoryProductSuccess({this.categoryProductList});
}

class CategoryProductFail extends ProductState {}


