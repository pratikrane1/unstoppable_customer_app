import 'package:meta/meta.dart';


@immutable
abstract class CategoryEvent {}


class OnLoadingCategoryList extends CategoryEvent {

  OnLoadingCategoryList();
}

class DeleteCategory extends CategoryEvent{
  String Categoryid;


  DeleteCategory({required this.Categoryid});
}



class OnLoadingCategoryDetail extends CategoryEvent {
  String CategoryId;
  OnLoadingCategoryDetail({required this.CategoryId});
}