import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:unstoppable_customer_app/Model/category_list.dart';

import '../../Model/category_product_model.dart';
import '../../Model/product_model.dart';
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
          perPage:event.per_page.toString(),
          startFrom:event.start_from.toString(),
      );

      final Iterable refactorCategory = response.result ?? [];
      final listCategory = refactorCategory.map((item) {
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
      final CategoryProductRepo response = await categoryRepo!
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



