// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
//
//
// Future<List<ProductNameModel>> fetchProductName(String subsubcatId) async{
//
//   Map<String, String> params;
//   params = {
//     // 'category_id': categoryData==null?"":categoryData.catId.toString(),
//     'sscat_id': subsubcatId.toString(),
//   };
//
//   var response = await http.post(
//       Uri.parse(Api.ProductName),
//       body: params
//   );
//
//   try{
//     final resp = json.decode(response.body);
//     List<ProductNameModel> listOfproductName=[];
//     ProductNameModel productName;
//     if( resp['result']=='Success') {
//       listOfproductName = resp['data'].map<ProductNameModel>((item) {
//         return ProductNameModel.fromJson(item);
//       }).toList();
//
//     }else{
//       productName=ProductNameModel();
//       productName.prodName='';
//       listOfproductName.add(productName);
//     }
//     return listOfproductName;
//   }catch(e){
//     print(e);
//     rethrow;
//   }
// }