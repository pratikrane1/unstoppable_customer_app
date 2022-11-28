
import '../../Model/category_list.dart';
import '../services/categoris_service.dart';

class CategoryRepository {

  final CategoryService service;

  CategoryRepository(this.service);

  Future<List<CategoryModel>> fetchCategory(int perPage, int startFrom) async {
    final categories = await service.fetchCategory(perPage,startFrom);
    return categories.map((e) => CategoryModel.fromJson(e)).toList();
  }
  
}