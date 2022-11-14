

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/product_model.dart';
import '../../Widget/app_button.dart';
import '../../Widget/common.dart';
import '../Cart/cart.dart';
import '../Login/sign_in.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_html/flutter_html.dart';



class ProductDetail extends StatefulWidget {
  ProductModel productData;
  ProductDetail({Key? key,required this.productData}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String descText = "* Description Line 1\n* Description Line 2\n* Description Line 3\n* Description Line 4\n* Description Line 5\n* Description Line 6\n* Description Line 7\n* Description Line 8";
  bool descTextShowFlag = false;

  // Initial Selected Value
  String dropdownvalue = 'Qty:1';

  // List of items in our dropdown menu
  var items = [
    'Qty:1',
    'Qty:2',
    'Qty:3',
    'Qty:4',
    'Qty:5',
  ];

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
      appBar:
      AppBar(
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
                Text("Product Detail",
                  style: TextStyle(color: ThemeColors.whiteTextColor,
                  fontFamily: 'SF-Pro-Display-Regular',
                  fontSize: 20),),
                notificationIcon(context),
              ],
            ),
          ],
        ),
        bottom:
        PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search for something',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(CupertinoIcons.mic_fill)),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        // color: Color(0xff000029),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                // elevation: 1,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productData.prodName.toString(),
                        style: TextStyle(
                            fontFamily: 'SF-Pro-Display-Medium',
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              height: 300,
                              width: 340,

                              filterQuality: FilterQuality.medium,
                              // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                              // imageUrl: "https://picsum.photos/250?image=9",
                              imageUrl: "${widget.productData.prodImg}",
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
                          ),
                          Positioned(
                            top: 5,
                            left: 10,
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ThemeColors.discountBackgroundColor,
                                child: Text(
                                  "27%\n off",
                                  style: TextStyle(
                                      fontFamily: 'SF-Pro-Display-Thin',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.whiteTextColor
                                  ),
                                )
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 10,
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ThemeColors.whiteTextColor.withOpacity(0.8),
                                child: IconButton(
                                  icon: Icon(Icons.share_outlined,
                                    color: ThemeColors.greyTextColor,
                                    size: 25,),
                                  onPressed: (){
                                    share();
                                  },
                                )
                            ),
                          )


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /2.1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween
                                      ,

                                      children: [
                                        Text(
                                          "MRP:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: ThemeColors.textFieldBgColor,
                                              fontSize: 18.0,
                                              fontFamily: 'SF-Pro-Display-Regular'
                                          ),
                                        ),
                                        Text(
                                          "\u{20B9} ${widget.productData.price}",
                                          style: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              fontWeight: FontWeight.normal,
                                              color: ThemeColors.textFieldBgColor,
                                              fontSize: 18.0,
                                              fontFamily: 'SF-Pro-Display-Regular'
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Deal Price
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Deal Price:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: ThemeColors.textFieldBgColor,
                                              fontSize: 18.0,
                                              fontFamily: 'SF-Pro-Display-Regular'
                                          ),
                                        ),
                                        Text(
                                          "\u{20B9} ${widget.productData.price}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 22.0,
                                              fontFamily: 'SF-Pro-Display-Regular'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: ThemeColors.buttonColor, style: BorderStyle.solid, ),
                                ),
                                child: DropdownButton(
                                  underline: DropdownButtonHideUnderline(child: Container()),

                                  // Initial Value
                                  value: dropdownvalue,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items, style: TextStyle(
                                          fontFamily: 'SF-Pro-Display-Regular',
                                          fontSize: 18
                                      ),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),






                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child:
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Center(
                              child: AppButton(
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                                },
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                text: 'Add to cart',
                                loading: true,
                                // disableTouchWhenLoading: true,
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),

            // Product detail
            Container(
                decoration: BoxDecoration(
                    color: ThemeColors.backgroundColor,
                    ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Product Details",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                          fontFamily: 'SF-Pro-Display-Bold'),)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              Text(
                                "Electric fan design",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                  fontSize: 16.0,
                                    fontFamily: 'SF-Pro-Display-Regular'
                                ),
                              ),

                              Text(
                                "Table Fan",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ]
                          ),

                          TableRow(
                              children: [
                                Text(
                                  "Special Feature",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ThemeColors.textFieldBgColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "Portable, Automatic",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Text(
                                  "Included Components",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ThemeColors.textFieldBgColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "Fan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Text(
                                  "Brand",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ThemeColors.textFieldBgColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "AmazonBasics",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Text(
                                  "Mounting Type",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ThemeColors.textFieldBgColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "Tabletop",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ]
                          ),
                        ],
                      ),
                     ),

                    SizedBox(
                      height: 10,
                    ),

                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Description",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SF-Pro-Display-Bold'),),
                          ),
                          Html(
                            data: widget.productData.description.toString(),
                          ),
                          // Text(widget.productData.description.toString())

                          // Text(descText,
                          //   maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,),),
                          // InkWell(
                          //   onTap: (){ setState(() {
                          //     descTextShowFlag = !descTextShowFlag;
                          //   }); },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: <Widget>[
                          //       descTextShowFlag
                          //           ?
                          //       Row(
                          //         children: [
                          //           Icon(Icons.arrow_drop_up),
                          //
                          //           Text("Show Less",style: TextStyle(color: Colors.blue),),
                          //         ],
                          //       )
                          //           :
                          //       Row(
                          //         children: [
                          //           Icon(Icons.arrow_drop_down),
                          //           Text("Show More Product detail",style: TextStyle(color: Colors.blue)),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            // Description

          ],
        ),
      ),

    );
  }



  Widget unstoppableProductCard() {
    return Container(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("High Speed Table Fan For Home, Cooling with Automatic Oscillation (400mm,55w,White)",
            style: TextStyle(
              fontFamily: 'SF-Pro-Display-Medium',
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    height: 300,
                    width: 340,

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
                ),
                Positioned(
                  top: 5,
                  left: 10,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: ThemeColors.discountBackgroundColor,
                    child: Text(
                      "27%\n off",
                      style: TextStyle(
                        fontFamily: 'SF-Pro-Display-Thin',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.whiteTextColor
                      ),
                    )
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ThemeColors.whiteTextColor.withOpacity(0.8),
                      child: IconButton(
                        icon: Icon(Icons.share_outlined,
                        color: ThemeColors.greyTextColor,
                        size: 25,),
                        onPressed: (){
                          share();
                        },
                      )
                  ),
                )


              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width /2.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                            ,

                            children: [
                              Text(
                                "MRP:",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                  fontSize: 18.0,
                                  fontFamily: 'SF-Pro-Display-Regular'
                                ),
                              ),
                              Text(
                                "\u{20B9} 15,000",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                    fontSize: 18.0,
                                    fontFamily: 'SF-Pro-Display-Regular'
                                ),
                              ),
                            ],
                          ),

                          // Deal Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deal Price:",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                    fontSize: 18.0,
                                    fontFamily: 'SF-Pro-Display-Regular'
                                ),
                              ),
                              Text(
                                "\u{20B9} 15,000",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                    fontSize: 22.0,
                                    fontFamily: 'SF-Pro-Display-Regular'
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: ThemeColors.buttonColor, style: BorderStyle.solid, ),
                      ),
                      child: DropdownButton(
                        underline: DropdownButtonHideUnderline(child: Container()),

                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items, style: TextStyle(
                              fontFamily: 'SF-Pro-Display-Regular',
                              fontSize: 18
                            ),),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),






              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child:
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Center(
                    child: AppButton(
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      text: 'Add to cart',
                      // loading: login is LoginLoading,
                      disableTouchWhenLoading: true,
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}