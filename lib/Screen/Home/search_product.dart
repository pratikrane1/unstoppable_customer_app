import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Screen/Home/product_details.dart';

import '../../Constant/theme_colors.dart';
import '../../Model/product_model.dart';
import '../../Model/search_product_model.dart';
import '../../NetworkFunction/searchProductApi.dart';
import '../Cart/cart.dart';

class SearchUser extends SearchDelegate {
  //ProductSearchModel _userList = ProductSearchModel();

 ProductSearchModel? productSearchData;
 ProductModel productData = ProductModel();
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
    return FutureBuilder<List<ProductModel>>(
        //future: _userList.getuserList(),
      future: fetchSearchProduct(query),
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(productData:data![index])));
                  },
                  child: Container(
                    height: 250,
                    padding: new EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CachedNetworkImage(
                            // width: 150,
                            // height: 150,
                            filterQuality: FilterQuality.medium,
                            // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                            // imageUrl: "https://picsum.photos/250?image=9",
                            imageUrl: '${data?[index].prodImg}',
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                baseColor: Theme.of(context).hoverColor,
                                highlightColor: Theme.of(context).highlightColor,
                                enabled: true,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Shimmer.fromColors(
                                baseColor: Theme.of(context).hoverColor,
                                highlightColor: Theme.of(context).highlightColor,
                                enabled: true,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.error),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10, right: 5),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data?[index].prodName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: ThemeColors.textColor,
                                        fontSize: 15.0,
                                        fontFamily: 'SF-Pro-Display-Regular'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "\u{20B9} ${data?[index].discountPrice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                        fontFamily: 'SF-Pro-Display-Bold'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\u{20B9} ${data?[index].price}",
                                        style: TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.0,
                                            fontFamily: 'SF-Pro-Display-Regular',
                                            color: ThemeColors.textFieldHintColor),
                                      ),
                                      // InkWell(
                                      //     onTap: () {
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) => CartPage(backIcon: true,)));
                                      //     },
                                      //     child: Icon(
                                      //       Icons.add_shopping_cart,
                                      //       color: ThemeColors.baseThemeColor,
                                      //     ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
                // return Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: ListTile(
                //       title: Row(
                //         children: [
                //           Container(
                //             width: 60,
                //             height: 60,
                //             decoration: BoxDecoration(
                //               color: Colors.deepPurpleAccent,
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             child: Center(
                //               child: Text(
                //                 '${data?[index].prodId}',
                //                 style: TextStyle(
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white),
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 20),
                //           Column(
                //               crossAxisAlignment:
                //               CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   '${data?[index].prodName}',
                //                   style: TextStyle(
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.w600),
                //                 ),
                //                 SizedBox(height: 10),
                //                 Text(
                //                   '${data?[index].description}',
                //                   style: TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 ),
                //               ])
                //         ],
                //       ),
                //       // trailing: Text('More Info'),
                //     ),
                //   ),
                // );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Product'),
    );
  }
}