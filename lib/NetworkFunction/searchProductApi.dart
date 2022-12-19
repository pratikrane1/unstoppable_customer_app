import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/product_model.dart';
import '../Model/search_product_model.dart';

Future<List<ProductModel>> fetchSearchProduct(String? query) async{

  Map<String, String> params;
  params = {
    'product_name': query.toString(),
  };
  var response = await http.post(
    Uri.parse('https://unstoppabletrade.in/customer_app/search_products'),
   body: params
  );

  try{
    final resp = json.decode(response.body);
    List<ProductModel> listOfCategory=[];
    // final Iterable refactorProduct = resp['results'] ?? [];
    // final searchData = refactorProduct.map((item) {
    //   return ProductSearchModel.fromJson(item);
    // }).toList();
    if( response.statusCode==200) {
      listOfCategory = resp['result'].map<ProductModel>((item) {
        return ProductModel.fromJson(item);
      }).toList();
      if (query!= null){
        listOfCategory = listOfCategory.where((element) => element.prodName!.toLowerCase().contains((query.toLowerCase()))).toList();
        }

    }
    return listOfCategory;
  }catch(e){
    print(e);
    rethrow;
  }
}

// class FetchUserList {
//   var data = [];
//   List<ProductSearchModel> results = [];
//   String urlList = 'https://unstoppabletrade.in/customer_app/search_products';
//
//   Future<List<ProductSearchModel>> getuserList({String? query, String? prodName}) async {
//     Map<String, String> params;
//     params = {
//     'product_name': prodName.toString(),
//   };
//
//   //  var url = Uri.parse(urlList);
//     try {
//      // var response = await http.post(url);
//       var response = await http.post(
//           Uri.parse(urlList),
//           body: params
//       );
//       if (response.statusCode == 200) {
//         data = json.decode(response.body);
//         results = data.map((e) => ProductSearchModel.fromJson(e)).toList();
//         if (query!= null){
//           results = results.where((element) => element.prodName!.toLowerCase().contains((query.toLowerCase()))).toList();
//         }
//       } else {
//         print("fetch error");
//       }
//     } on Exception catch (e) {
//       print('error: $e');
//     }
//     return results;
//   }
// }