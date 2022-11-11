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

class CategoryListLoadFail extends CategoryState {}



class DeleteCategorySuccess extends CategoryState {
 DeleteCategorySuccess();
}



