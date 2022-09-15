

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../Constant/theme_colors.dart';
import '../../Widget/app_button.dart';
import '../../Widget/common.dart';
import '../Cart/cart.dart';
import '../Login/sign_in.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key,}) : super(key: key);

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
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hi OM", style: TextStyle(color: ThemeColors.whiteTextColor),),
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
      floatingActionButton: Padding(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        // color: Color(0xff000029),
        child: ListView(
          children: [
            unstoppableProductCard(),
            // Product detail
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Product Detail",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child:Row(

                      children: [
                        Container(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Electric fan design",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: ThemeColors.textFieldBgColor,
                                      fontSize: 16.0,
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
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Special Feature
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Included
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Included\nComponents",
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
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Brand
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Mounting Type
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    "TabelTop",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),






                  ),

                ],
              ),
            ),
            // Description
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(descText,
                    maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,),),
                  InkWell(
                    onTap: (){ setState(() {
                      descTextShowFlag = !descTextShowFlag;
                    }); },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        descTextShowFlag ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More Product detail",style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

          children: [
            Text("High Speed Table Fan For Home, Cooling with Automatic Oscillation (400mm,55w,White)"),
            SizedBox(
              height: 5,
            ),
            CachedNetworkImage(
              height: 180,
              width: 310,
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
                    height: 180,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Stack(
                  children: [
                    Container(
                      height: 180,
                      width: 310,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: Color(0xffc32c37),
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1)),
                        child: InkWell(
                          onTap: (){
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NotificationPage()));

                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.black,
                                    size: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: Color(0xffc32c37),
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1)),
                        child: InkWell(
                          onTap: (){
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NotificationPage()));

                          },
                          child: Container(

                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Color(0xffc32c37),
                                color: Colors.red,
                                border: Border.all(color: Colors.black,)),
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                const Center(
                                  child: Text("27% off",style: TextStyle(color: Colors.white,fontSize: 9,fontWeight:FontWeight.bold),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                            ,

                            children: [
                              Text(
                                "MRP",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "\u{20B9} 15,000",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),

                          // Deal Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deal Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "\u{20B9} 15,000",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DropdownButton(

                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
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
                  ],
                ),






              ),
            )


          ],
        ),
      ),
    );
  }
}