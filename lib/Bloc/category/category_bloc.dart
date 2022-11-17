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


class CategoryBloc extends Bloc<ProductEvent, ProductState> {
  CategoryBloc({this.productRepo}) : super(InitialProductListState());
  final UserRepository? productRepo;


  @override
  Stream<ProductState> mapEventToState(event) async* {
    if (event is OnLoadingProductList) {
      ///Notify loading to UI
      yield ProductLoading();

      ///Fetch API via repository
      final CategoryRepo response = await productRepo!
          .fetchProduct(
        startFrom: event.startFrom,
        perPage: event.perPage
      );

      final Iterable refactorProduct = response.result ?? [];
      final listproduct = refactorProduct.map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
      if (refactorProduct.length > 0) {
        yield ProductListSuccess(productList: listproduct);
      } else {
        yield ProductListLoadFail();
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



