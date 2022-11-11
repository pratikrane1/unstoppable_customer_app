import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:unstoppable_customer_app/Model/category_list.dart';

import '../../Model/category_list.dart';
import '../../Model/category_list.dart';
import '../../Model/category_list.dart';
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
          .fetchProduct();

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

    // //Product Detail
    // if (event is OnLoadingProductDetail) {
    //   ///Notify loading to UI
    //   yield ProductDetailLoading();
    //
    //   ///Fetch API via repository
    //   final ProductDetailRepo result = await productRepo!
    //       .fetchProductDetail(
    //       productId: event.prodId
    //   );
    //
    //   ///Case API fail but not have token
    //   if (result.result == "Success") {
    //     ProductDetail productDetail = new ProductDetail();
    //     productDetail = result.data;
    //
    //     yield ProductDetailSuccess(data: productDetail);
    //   }
    // }
    //
    //
    // //remove product
    // if (event is DeleteProduct) {
    //   yield DeleteProductLoading();
    //   Map<String, String> params;
    //   params = {
    //     'product_id': event.productid
    //   };
    //
    //   var response = await http.post(
    //       Uri.parse(Api.delProduct),
    //       body: params
    //   );
    //
    //   try {
    //     final resp = json.decode(response.body);
    //     if (resp['result'] == 'Success') {
    //       yield DeleteProductSuccess();
    //     }
    //   } catch (e) {
    //     print(e);
    //     rethrow;
    //   }
    // }
    //

  }
}



