import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/my_order.dart';
import '../Model/product_model.dart';
import '../Model/search_product_model.dart';

Future<List<Orders>> fetchSearchOrder(String? query) async{

  Map<String, String> params;
  params = {
    'user_id': query.toString(),
  };
  var response = await http.post(
      Uri.parse('https://unstoppabletrade.in/customer_app/my_orders'),
      body: params
  );

  try{
    final resp = json.decode(response.body);
    List<Orders> listOfOrders=[];
    // final Iterable refactorProduct = resp['results'] ?? [];
    // final searchData = refactorProduct.map((item) {
    //   return ProductSearchModel.fromJson(item);
    // }).toList();
    if( response.statusCode==200) {
      listOfOrders = resp['result'].map<Orders>((item) {
        return Orders.fromJson(item);
      }).toList();
      if (query!= null){
        listOfOrders = listOfOrders.where((element) => element.orderId!.toLowerCase().contains((query.toLowerCase()))).toList();
      }

    }
    return  listOfOrders;
  }catch(e){
    print(e);
    rethrow;
  }
}


