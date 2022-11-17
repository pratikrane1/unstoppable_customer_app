import 'package:meta/meta.dart';


@immutable
abstract class CategoryEvent {}


class OnLoadingCategoryList extends CategoryEvent {
 int per_page;
 int start_from;
  OnLoadingCategoryList({required this.per_page,required this.start_from });
}


class OnLoadingCategoryProductList extends ProductEvent{
  String ssCatId;
  OnLoadingCategoryProductList({required this.ssCatId});



class OnLoadingCategoryDetail extends CategoryEvent {
  String CategoryId;
  OnLoadingCategoryDetail({required this.CategoryId});
}