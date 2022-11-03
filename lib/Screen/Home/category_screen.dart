

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Screen/Home/product_details.dart';

import '../../Constant/theme_colors.dart';
import '../Cart/cart.dart';

class CategoryScreen extends StatefulWidget {

  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {

            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios,
            color: ThemeColors.whiteTextColor,),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category",
                  style: TextStyle(color: ThemeColors.whiteTextColor,
                      fontFamily: 'SF-Pro-Display-Regular',
                      fontSize: 20),),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              buildProductCard(context)

            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2.5;
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail()));
      },
      child: Padding(
        // padding: const EdgeInsets.only(left:8.0,right: 8.0),
        padding: const EdgeInsets.all(8),
        child:
        GridView.count(
          childAspectRatio: (itemWidth / itemHeight),

          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          // crossAxisSpacing: 10,
          children: List.generate(10, (index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CachedNetworkImage(
                    width: 150,
                    height: 150,
                    filterQuality: FilterQuality.medium,
                    // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                    // imageUrl: "https://picsum.photos/250?image=9",
                    imageUrl: "https://picsum.photos/250?image=9",
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
                    padding: const EdgeInsets.only(left: 15,top: 10,right: 5),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "High speed table fan for home",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.textColor,
                                fontSize: 15.0,
                                fontFamily: 'SF-Pro-Display-Regular'
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\u{20B9} 15,000",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                fontFamily: 'SF-Pro-Display-Bold'
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\u{20B9} 20,000.00",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                    fontFamily: 'SF-Pro-Display-Regular',
                                    color: ThemeColors.textFieldHintColor

                                ),
                              ),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                                  },
                                  child: Icon(Icons.add_shopping_cart,color: ThemeColors.baseThemeColor,))
                            ],
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }



}