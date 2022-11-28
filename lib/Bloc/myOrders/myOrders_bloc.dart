import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../Api/api.dart';
import '../../Model/category_product_model.dart';
import '../../Model/model_trackOrder.dart';
import '../../Model/my_order.dart';
import '../../Model/product_model.dart';
import '../../Repository/UserRepository.dart';
import '../../Utils/application.dart';
import 'myOrders_event.dart';
import 'myOrders_state.dart';


class MyOrdersBloc extends Bloc<MyOrdersEvent,MyOrdersState> {
  MyOrdersBloc({required this.ordersRepo}) : super(InitialOrdersListState());
  final UserRepository ordersRepo;

  @override
  Stream<MyOrdersState> mapEventToState(event) async* {
    // TODO: implement mapEventToState

    //for ordersList
    if (event is OnLoadingOrdersList) {
      ///Notify loading to UI
      yield MyOrdersLoading();

      ///Fetch API via repository
      final MyOrdersResp response = await ordersRepo!
          .fetchMyOrdersList(
        userId: event.userId,
      );

      final Iterable refactorProduct = response.result ?? [];
      final listorder = refactorProduct.map((item) {
        return Orders.fromJson(item);
      }).toList();
      print(listorder);
      // final Iterable productList = listorder[''].products ?? [];
      // final listProduct = refactorProduct.map((item) {
      //   return Products.fromJson(item);
      // }).toList();
      // print(listProduct);
      if (refactorProduct.length > 0) {
        yield MyOrdersListSuccess(orderList: listorder, orderData: response);
      } else {
        yield MyOrdersListLoadFail();
      }
    }

    //
    //Cancel Order
    if (event is CancelOrder) {
      yield CancelOrderLoading();
      Map<String, String> params;
      params = {
        'user_id': event.userId,
        'order_id': event.orderId,
      };

      var response = await http.post(
          Uri.parse(Api.CANCEL_MYORDER),
          body: params
      );

      try {
        final resp = json.decode(response.body);
        if (resp["status"] == true) {
          yield CancelOrderSuccess(message: resp["msg"]);
        }else{
          CancelOrderFail(message: resp["msg"]);
        }
      } catch (e) {
        print(e);
        rethrow;
      }
    }

    //Orders Detail
    if (event is OnLoadingOrdersDetail) {
      ///Notify loading to UI
      yield OrdersDetailLoading();

      ///Fetch API via repository
      final MyOrdersResp response = await ordersRepo!
          .fetchOrdersDetail(
          orderId: event.orderId
      );

      ///Case API fail but not have token
      final Iterable refactorProduct = response.result ?? [];
      final listorder = refactorProduct.map((item) {
        return Orders.fromJson(item);
      }).toList();
      if (refactorProduct.length > 0) {
        yield MyOrdersDetailSuccess(orderList: listorder, data: response);
      } else {
        yield MyOrdersListLoadFail();
      }
    }

    // for track order
    if (event is OnLoadingTrackOrderList) {
      ///Notify loading to UI
      yield TrackOrdersLoading();

      ///Fetch API via repository
      final TrackOrderResp response = await ordersRepo.fetchTrackOrdersList(
        orderId: event.orderId,
      );

      print(response);

      final Iterable refactortrackorder = response.result ?? [];
      // String currentStatus = response.result.retRplc;
      final trackorders = refactortrackorder.map((item) {
        return TrackData.fromJson(item);
      }).toList();
      if (refactortrackorder.length > 0) {
        yield TrackOrdersListSuccess(message: response.msg.toString(),
            trackOrderList: trackorders,);
      } else {
        yield TrackOrdersListLoadFail(message: response.msg.toString());
      }
    }


    // For Products

    if (event is GetProduct) {
      ///Notify loading to UI
      yield ProductLoading();

      ///Fetch API via repository
      // final ProductRepo response = await ordersRepo!
      //     .fetchOrderProduct(
      //   sscatId: event.sscatId,
      // );

      final CategoryProductRepo response = await ordersRepo!
          .fetchProductCategory(
          ssCatId: event.sscatId
      );

      print(response);

      final Iterable refactorProduct = response.result ?? [];
      final products = refactorProduct.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
      if (refactorProduct.length > 0) {
        yield ProductSuccess(
            message: response.msg.toString(), productData: products);
      } else {
        yield Productfail(message: response.msg.toString());
      }
    }
  }}



