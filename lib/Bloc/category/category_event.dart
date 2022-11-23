import 'package:meta/meta.dart';


@immutable
abstract class CategoryEvent {}


class OnLoadingCategoryList extends CategoryEvent {
 int per_page;
 int start_from;
  OnLoadingCategoryList({required this.per_page,required this.start_from });
}


class OnLoadingCategoryProductList extends CategoryEvent {
  String ssCatId;

  OnLoadingCategoryProductList({required this.ssCatId});
}
