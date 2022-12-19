import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Screen/Home/product_details.dart';

import '../../Constant/theme_colors.dart';
import '../../Model/my_order.dart';
import '../../Model/product_model.dart';
import '../../Model/search_product_model.dart';
import '../../NetworkFunction/searchOrderApi.dart';
import '../../NetworkFunction/searchProductApi.dart';
import '../Cart/cart.dart';
import 'myOrderDetail_screen.dart';

class SearchOrder extends SearchDelegate {
  //ProductSearchModel _userList = ProductSearchModel();

  ProductSearchModel? productSearchData;
  Orders orderData = Orders();
  //List<ProductModel> productData = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }



  @override
  Widget buildResults(BuildContext context,) {
    return FutureBuilder<List<Orders>>(
      //future: _userList.getuserList(),
        future: fetchSearchOrder(query),
        builder: (context, snapshot) {
          var data = snapshot.data;
          // List<ProductModel>? data = snapshot.data?.cast<ProductModel>();
          // var data = snapshot.data as List<ProductSearchModel>;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyOrdersDetail(myOrderList: data![index],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 0.9, color: ThemeColors.buttonColor),
                          // color: Colors.black12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10.0),
                              //   border: Border.all(width: 1, color: ThemeColors.buttonColor),
                              //   // color: Colors.black12,
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Order ID: ",
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0,
                                                  fontFamily: 'SF-Pro-Display-Bold'
                                                //color: Theme.of(context).accentColor
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${data?[index].orderId}',
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0,
                                                  fontFamily: 'SF-Pro-Display-Bold'
                                                //color: Theme.of(context).accentColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 1.9,
                                        child: Text(
                                          '${data?[index].orderDate}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: ThemeColors.greyTextColor
                                                  .withOpacity(0.7),
                                              fontSize: 10.0,
                                              fontFamily: 'SF-Pro-Display-Regular'),
                                          maxLines: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '\u{20B9} '+'${data?[index].subTotal}',
                                        style: TextStyle(
                                          fontFamily: 'SF-Pro-Display-Bold',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));

              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Order'),
    );
  }
}