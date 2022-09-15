
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../Constant/theme_colors.dart';
import '../../Widget/app_button.dart';
import '../Login/sign_in.dart';

class MyOrdersDetail extends StatefulWidget {
  MyOrdersDetail({Key? key,}) : super(key: key);

  @override
  State<MyOrdersDetail> createState() => _MyOrdersDetailState();
}

class _MyOrdersDetailState extends State<MyOrdersDetail> {

  @override
    Widget build(BuildContext context) {

      // Widget buildOrdersList() {
      //   // if (productList.length <= 0) {
      //   //   return ListView.builder(
      //   //     scrollDirection: Axis.vertical,
      //   //     // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      //   //     itemBuilder: (context, index) {
      //   //       return Shimmer.fromColors(
      //   //         baseColor: Theme.of(context).hoverColor,
      //   //         highlightColor: Theme.of(context).highlightColor,
      //   //         enabled: true,
      //   //         child: Padding(
      //   //           padding: const EdgeInsets.all(8.0),
      //   //           child: Container(
      //   //             width: MediaQuery.of(context).size.width,
      //   //             child: ListTile(
      //   //               contentPadding: EdgeInsets.zero,
      //   //               //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      //   //               // leading: nameIcon(),
      //   //               leading: CachedNetworkImage(
      //   //                 filterQuality: FilterQuality.medium,
      //   //                 // imageUrl: Api.PHOTO_URL + widget.users.avatar,
      //   //                 imageUrl: "https://picsum.photos/250?image=9",
      //   //                 // imageUrl: model.cart[index].productImg == null
      //   //                 //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
      //   //                 //     : model.cart[index].productImg,
      //   //                 placeholder: (context, url) {
      //   //                   return Shimmer.fromColors(
      //   //                     baseColor: Theme.of(context).hoverColor,
      //   //                     highlightColor: Theme.of(context).highlightColor,
      //   //                     enabled: true,
      //   //                     child: Container(
      //   //                       height: 80,
      //   //                       width: 80,
      //   //                       decoration: BoxDecoration(
      //   //                         color: Colors.white,
      //   //                         borderRadius: BorderRadius.circular(8),
      //   //                       ),
      //   //                     ),
      //   //                   );
      //   //                 },
      //   //                 imageBuilder: (context, imageProvider) {
      //   //                   return Container(
      //   //                     height: 80,
      //   //                     width: 80,
      //   //                     decoration: BoxDecoration(
      //   //                       image: DecorationImage(
      //   //                         image: imageProvider,
      //   //                         fit: BoxFit.cover,
      //   //                       ),
      //   //                       borderRadius: BorderRadius.circular(8),
      //   //                     ),
      //   //                   );
      //   //                 },
      //   //                 errorWidget: (context, url, error) {
      //   //                   return Shimmer.fromColors(
      //   //                     baseColor: Theme.of(context).hoverColor,
      //   //                     highlightColor: Theme.of(context).highlightColor,
      //   //                     enabled: true,
      //   //                     child: Container(
      //   //                       height: 80,
      //   //                       width: 80,
      //   //                       decoration: BoxDecoration(
      //   //                         color: Colors.white,
      //   //                         borderRadius: BorderRadius.circular(8),
      //   //                       ),
      //   //                       child: Icon(Icons.error),
      //   //                     ),
      //   //                   );
      //   //                 },
      //   //               ),
      //   //               title: Column(
      //   //                 children: [
      //   //                   Align(
      //   //                     alignment: Alignment.centerLeft,
      //   //                     child: Text(
      //   //                       "Loading...",
      //   //                       overflow: TextOverflow.clip,
      //   //                       style: TextStyle(
      //   //                         fontWeight: FontWeight.bold,
      //   //                         fontSize: 15.0,
      //   //                         //color: Theme.of(context).accentColor
      //   //                       ),
      //   //                     ),
      //   //                   ),
      //   //                   Column(
      //   //                     crossAxisAlignment: CrossAxisAlignment.start,
      //   //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   //                     children: [
      //   //                       Row(
      //   //                         children: [
      //   //                           Text(
      //   //                             ".......",
      //   //                             style: TextStyle(
      //   //                               fontWeight: FontWeight.normal,
      //   //                               color: Colors.black87,
      //   //                               fontSize: 14.0,
      //   //                             ),
      //   //                           ),
      //   //                           SizedBox(
      //   //                             width: 20,
      //   //                           )
      //   //                         ],
      //   //                       ),
      //   //                     ],
      //   //                   ),
      //   //                 ],
      //   //               ),
      //   //             ),
      //   //             decoration: BoxDecoration(
      //   //                 borderRadius: BorderRadius.all(Radius.circular(20)),
      //   //                 color: Colors.white),
      //   //           ),
      //   //         ),
      //   //       );
      //   //     },
      //   //     itemCount: List.generate(8, (index) => index).length,
      //   //   );
      //   // }
      //
      //   // return ListView.builder(
      //   return ListView.builder(
      //     shrinkWrap: true,
      //     scrollDirection: Axis.horizontal,
      //     padding: EdgeInsets.only(top: 10, bottom: 15),
      //     itemBuilder: (context, index) {
      //       return unstoppableProductCard();
      //     },
      //     itemCount: 20,
      //   );
      // }

      Widget buildInterestedCard(){
        return
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                semanticContainer: true,

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Column(

                  children: [
                    SizedBox(
                      height: 20,
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
                            borderRadius: BorderRadius.circular(8),
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
                      padding: const EdgeInsets.all(15.0),
                      child: Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Item Name", style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SF-Pro-Display-Bold',
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2.5,
                              child: Text(
                                "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                                style: TextStyle(
                                  fontFamily: 'SF-Pro-Display-Regular',
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColors.greyTextColor.withOpacity(0.7),
                                  fontSize: 10.0,
                                ),
                                maxLines: 3,

                              ),
                            ),
                            // Text(
                            //   "Neque porro quisquam est qui dolorem\n ipsum quia dolor sit amet, consectetur,\n adipisci velit...",
                            //
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w500,
                            //       color: ThemeColors.greyTextColor.withOpacity(0.7),
                            //       fontSize: 10.0,
                            //       fontFamily: 'SF-Pro-Display-Regular'
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "\u{20B9} 15,000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  fontFamily: 'SF-Pro-Display-Bold'
                              ),
                            ),
                          ],
                        ),
                      ),
                    )


                  ],
                ),
              );

            },
          );

      }


      // TODO: implement build
      return Scaffold(
        appBar:AppBar(
          leading: GestureDetector(
            onTap: () {

              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: ThemeColors.whiteTextColor),
          ),
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SF-Pro-Display-Regular',
                      color: ThemeColors.whiteTextColor
                  ),),
                  // myAppBarIcon(),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: ThemeColors.orderDetailBGColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Order Id  - ",
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ThemeColors.orderIdTextColor
                              ),),
                              Text("123456789zxc",
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors.orderIdTextColor

                                ),)
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10.0),
                              //   border: Border.all(width: 1, color: ThemeColors.buttonColor),
                              //   // color: Colors.black12,
                              // ),
                              child: Row(
                                children: [
                                CachedNetworkImage(
                                  height: 100,
                                    width: 100,

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
                                          borderRadius: BorderRadius.circular(8),
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
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Delivered on Jan 25",
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                              fontFamily: 'Poppins-SemiBold'
                                              //color: Theme.of(context).accentColor
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width/2.5,
                                          child: Text(
                                            "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontWeight: FontWeight.w500,
                                              color: ThemeColors.greyTextColor.withOpacity(0.7),
                                              fontSize: 10.0,
                                            ),
                                            maxLines: 3,

                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "\u{20B9} 15,000",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            fontFamily: 'SF-Pro-Display-Bold'
                                          ),
                                        ),




                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        AppButton(
                          onPressed: () async {},
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          text: 'Download Invoice',
                          // loading: login is LoginLoading,
                          disableTouchWhenLoading: true,
                        )
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),


                  Container(
                    // decoration: new BoxDecoration(
                    //   borderRadius: new BorderRadius.circular(16.0),
                    //   color: ThemeColors.orderDetailBGColor,
                    // ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("You might be also Interested in",
                            style: TextStyle(
                              fontFamily: 'SF-Pro-Display-Medium',
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),),),

                        SizedBox(
                          height: 20,
                        ),


                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.7,

                          child: buildInterestedCard(),
                        )
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),

      );
    }



}