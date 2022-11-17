import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:unstoppable_customer_app/Model/category_list.dart';

import '../../Repository/UserRepository.dart';
import '../../Utils/application.dart';
import 'category_event.dart';
import 'category_state.dart';

//for multipart
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({this.categoryRepo}) : super(InitialCategoryListState());
  final UserRepository? categoryRepo;


  @override
  Stream<CategoryState> mapEventToState(event) async* {
    if (event is OnLoadingCategoryList) {
      ///Notify loading to UI
      yield CategoryLoading();

      ///Fetch API via repository
      final CategoryRepo response = await categoryRepo!
          .fetchCategory(
          per_page:event.per_page.toString(),
          start_from:event.start_from.toString(),
      );

      final Iterable refactorProduct = response.result ?? [];
      final listproduct = refactorProduct.map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      if (refactorCategory.length > 0) {
        yield CategoryListSuccess(CategoryList: listCategory);
      } else {
        yield CategoryListLoadFail();
      }
    }

    if (event is OnLoadingCategoryProductList) {
      ///Notify loading to UI
      yield CategoryProductLoading();

      ///Fetch API via repository
      final CategoryProductRepo response = await productRepo!
          .fetchProductCategory(
          ssCatId: event.ssCatId
      );

      final Iterable refactorProduct = response.result ?? [];
      final listproduct = refactorProduct.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
      if (refactorProduct.length > 0) {
        yield CategoryProductSuccess(categoryProductList: listproduct);
      } else {
        yield CategoryProductFail();
      }
    }
  }
}



