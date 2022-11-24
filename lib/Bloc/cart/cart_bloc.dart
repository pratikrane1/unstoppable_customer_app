
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:unstoppable_customer_app/Api/api.dart';
import 'package:unstoppable_customer_app/Bloc/authentication/authentication_event.dart';
import 'package:unstoppable_customer_app/Utils/application.dart';

import '../../Model/address_model.dart';
import '../../Model/cart_model.dart';
import '../../Repository/UserRepository.dart';
import '../../app_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:http/http.dart' as http;


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({this.cartRepo}) : super(InitialCartState());
  final UserRepository? cartRepo;


  @override
  Stream<CartState> mapEventToState(event) async* {

    ///Add to cart
    if (event is AddToCart) {
      ///Notify loading to UI
      yield AddCartLoading();

      ///Fetch API via repository
      final CartRepo response = await cartRepo!
          .addToCart(
          user_id: event.user_id,
          prodId: event.prod_id,
          quantity: event.quantity
      );

      print(response);

      if (response.status == true) {
        ///Login API success
        //  CustomerLogin user = CustomerLogin.fromJson(result.data);
        // CustomerLogin user = new CustomerLogin();
        // user.status = result.data!.status.toString();
        // user = result.data!;
        // AppBloc.authBloc.add(OnSaveUser(user));
        try {
          yield AddCartSuccess(message: response.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield AddCartfail(message: response.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield AddCartfail(message: response.msg.toString());
      }
    }


    ///Cart List
    if (event is GetCart) {
      ///Notify loading to UI
      yield CartListLoading();

      ///Fetch API via repository
      final CartListRepo response = await cartRepo!
          .fetchCartData(
          user_id: event.user_id,
      );

      print(response);


      final Iterable refactorProduct = response.result ?? [];
      final cartList = refactorProduct.map((item) {
        return CartListModel.fromJson(item);
      }).toList();
      if (refactorProduct.length > 0) {
        AppBloc.authBloc.add(OnSaveCart(response));
        yield CartListSuccess(message: response.msg.toString(), cartList: cartList, cartData: response);
      } else {
        yield CartListfail(message: response.msg.toString());
      }
    }

    ///Delete Cart
    if (event is DeleteCart) {
      ///Notify loading to UI
      yield DeleteCartLoading();

      ///Fetch API via repository
      final CartRepo response = await cartRepo!
          .deleteCart(
          user_id: event.user_id,
          prodId: event.prod_id,
      );

      print(response);

      if (response.status == true) {
        ///Login API success
        //  CustomerLogin user = CustomerLogin.fromJson(result.data);
        // CustomerLogin user = new CustomerLogin();
        // user.status = result.data!.status.toString();
        // user = result.data!;
        // AppBloc.authBloc.add(OnSaveUser(user));
        try {
          yield DeleteCartSuccess(message: response.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield DeleteCartfail(message: response.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield DeleteCartfail(message: response.msg.toString());
      }
    }


    ///Checkout
    if (event is CheckOut) {
      ///Notify loading to UI
      yield CheckOutLoading();

      ///Fetch API via repository
      // final CartRepo response = await cartRepo!
      //     .checkOut(
      //   user_id: event.user_id,
      //   shippingCharge: event.shippingCharge,
      //   subTotal: event.subTotal,
      //   address: event.address,
      //   totalAmount: event.totalAmount,
      //   paymentMethod: event.paymentMethod,
      //   cart: event.cart.toString()
      // );
      //
      // print(response);

      // var cart = [];
      //
      // for(int j = 0; j < event.cart.length; j++){
      //
      //   var innerObj ={};
      //
      //   innerObj["prod_id"] = event.cart[j].prodId;
      //   innerObj["price"] = event.cart[j].price;
      //   innerObj["quantity"] = event.cart[j].quantity;
      //   cart.add(innerObj);
      // }
      //
      // Map<String, String> data = {
      //   "user_id":event.user_id.toString(),
      //   "sub_total":event.subTotal.toString(),
      //   "shipping_charge":event.shippingCharge.toString(),
      //   "total_amount":event.totalAmount.toString(),
      //   "payment_method":event.paymentMethod.toString(),
      //   "billing_address":event.address.toString(),
      //   "product_details":cart.toString(),
      // };
      //
      // var request = new  MultipartRequest("POST", Uri.parse(Api.CHECKOUT));
      // request.fields.addAll(data);
      //
      // request.send().then((response) {
      //   if (response.statusCode == 200) print("done!");
      // });


      var socialMedia = [];

      for(int j = 0; j < event.cart.length; j++){

        var innerObj ={};

        innerObj["prod_id"] = event.cart[j].prodId;
        innerObj["price"] = event.cart[j].price;
        innerObj["quantity"] = event.cart[j].quantity;
        socialMedia.add(innerObj);
      }

      var mainObj={};
      mainObj["user_id"]=event.user_id.toString();
    mainObj["sub_total"]=event.subTotal.toString();
    mainObj["shipping_charge"]=event.shippingCharge.toString();
    mainObj["total_amount"];event.totalAmount.toString();
    mainObj["payment_method"]=event.paymentMethod.toString();
    mainObj["billing_address"]=event.address.toString();
    mainObj["product_details"]=socialMedia;

      final response = await http.post(
          Uri.parse(Api.CHECKOUT),
          body: jsonEncode(mainObj)
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        if (responseJson['status'] == true) {
          yield CheckOutSuccess(message: responseJson['msg']);
        } else {
          yield CheckOutfail(message: responseJson['msg']);
        }
      }

      // MultipartRequest request = new MultipartRequest(
      //     'POST', Uri.parse(Api.CHECKOUT));
      // request.fields['user_id'] = event.user_id;
      // request.fields['sub_total'] = event.subTotal;
      // request.fields['shipping_charge'] = event.shippingCharge;
      // request.fields['total_amount'] = event.totalAmount;
      // request.fields['payment_method'] = event.paymentMethod;
      // request.fields['billing_address'] = event.address;
      // request.fields['product_details'] = cart;
      //
      //
      //
      // final streamedResponse = await request.send();
      // final response = await http.Response.fromStream(streamedResponse);
      // var responseData = json.decode(response.body);
      // if (responseData['result'] == 'Success') {
      //   yield CheckOutSuccess(message: responseData['msg']);
      // } else {
      //   yield CheckOutfail(message: responseData['msg']);
      // }

      // if (response.status == true) {
      //   ///Login API success
      //   //  CustomerLogin user = CustomerLogin.fromJson(result.data);
      //   // CustomerLogin user = new CustomerLogin();
      //   // user.status = result.data!.status.toString();
      //   // user = result.data!;
      //   // AppBloc.authBloc.add(OnSaveUser(user));
      //   try {
      //     yield CheckOutSuccess(message: response.msg.toString());
      //   } catch (error) {
      //     ///Notify loading to UI
      //     yield CheckOutfail(message: response.msg.toString());
      //   }
      // } else {
      //   ///Notify loading to UI
      //   yield CheckOutfail(message: response.msg.toString());
      // }
    }



  }
}
