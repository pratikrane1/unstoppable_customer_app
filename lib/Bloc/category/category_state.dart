import 'package:meta/meta.dart';

import '../../Model/category_list.dart';
import '../../Model/category_product_model.dart';
import '../../Model/product_model.dart';


@immutable
abstract class CategoryState {}


class InitialCategoryListState extends CategoryState {}


class CategoryLoading extends CategoryState {}

class DeleteCategoryLoading extends CategoryState {}
////
class CategoryListLoading extends CategoryState {
 List<CategoryModel>? CategoryList;
 final bool isFirstFetch;
 CategoryListLoading(this.CategoryList,{this.isFirstFetch=false});
}


class CategoryListLoaded extends CategoryState {
 List<CategoryModel>? CategoryList;
 CategoryListLoaded(List<CategoryModel>? Categorys, {this.CategoryList});
}
////
class CategoryListSuccess extends CategoryState {
 List<CategoryModel>? CategoryList;
 CategoryListSuccess({this.CategoryList});
}

class CategoryListLoadFail extends CategoryState {}




class CategoryProductLoading extends CategoryState {}



class CategoryProductSuccess extends ProductState {
 List<ProductModel>? categoryProductList;

 CategoryProductSuccess({this.categoryProductList});
}

class CategoryProductFail extends CategoryState {}


