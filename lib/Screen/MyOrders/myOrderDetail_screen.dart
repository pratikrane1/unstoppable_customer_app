
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

    Widget buildOrdersList() {
      // if (productList.length <= 0) {
      //   return ListView.builder(
      //     scrollDirection: Axis.vertical,
      //     // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      //     itemBuilder: (context, index) {
      //       return Shimmer.fromColors(
      //         baseColor: Theme.of(context).hoverColor,
      //         highlightColor: Theme.of(context).highlightColor,
      //         enabled: true,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             width: MediaQuery.of(context).size.width,
      //             child: ListTile(
      //               contentPadding: EdgeInsets.zero,
      //               //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      //               // leading: nameIcon(),
      //               leading: CachedNetworkImage(
      //                 filterQuality: FilterQuality.medium,
      //                 // imageUrl: Api.PHOTO_URL + widget.users.avatar,
      //                 imageUrl: "https://picsum.photos/250?image=9",
      //                 // imageUrl: model.cart[index].productImg == null
      //                 //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
      //                 //     : model.cart[index].productImg,
      //                 placeholder: (context, url) {
      //                   return Shimmer.fromColors(
      //                     baseColor: Theme.of(context).hoverColor,
      //                     highlightColor: Theme.of(context).highlightColor,
      //                     enabled: true,
      //                     child: Container(
      //                       height: 80,
      //                       width: 80,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(8),
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 imageBuilder: (context, imageProvider) {
      //                   return Container(
      //                     height: 80,
      //                     width: 80,
      //                     decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                         image: imageProvider,
      //                         fit: BoxFit.cover,
      //                       ),
      //                       borderRadius: BorderRadius.circular(8),
      //                     ),
      //                   );
      //                 },
      //                 errorWidget: (context, url, error) {
      //                   return Shimmer.fromColors(
      //                     baseColor: Theme.of(context).hoverColor,
      //                     highlightColor: Theme.of(context).highlightColor,
      //                     enabled: true,
      //                     child: Container(
      //                       height: 80,
      //                       width: 80,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(8),
      //                       ),
      //                       child: Icon(Icons.error),
      //                     ),
      //                   );
      //                 },
      //               ),
      //               title: Column(
      //                 children: [
      //                   Align(
      //                     alignment: Alignment.centerLeft,
      //                     child: Text(
      //                       "Loading...",
      //                       overflow: TextOverflow.clip,
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 15.0,
      //                         //color: Theme.of(context).accentColor
      //                       ),
      //                     ),
      //                   ),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Text(
      //                             ".......",
      //                             style: TextStyle(
      //                               fontWeight: FontWeight.normal,
      //                               color: Colors.black87,
      //                               fontSize: 14.0,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             width: 20,
      //                           )
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.all(Radius.circular(20)),
      //                 color: Colors.white),
      //           ),
      //         ),
      //       );
      //     },
      //     itemCount: List.generate(8, (index) => index).length,
      //   );
      // }

      // return ListView.builder(
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 10, bottom: 15),
        itemBuilder: (context, index) {
          return unstoppableProductCard();
        },
        itemCount: 20,
      );
    }


    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        leading: GestureDetector(
          onTap: () {

            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: false,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Details"),
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
                    color: ThemeColors.backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Order Id -"),
                            Text("123456789zxc")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   border: Border.all(width: 1, color: ThemeColors.buttonColor),
                            //   // color: Colors.black12,
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                // leading: nameIcon(),
                                leading: CachedNetworkImage(

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
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Delivered on Jan 25",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          //color: Theme.of(context).accentColor
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: ThemeColors.textFieldBgColor,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "\u{20B9} 15,000",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),




                                  ],
                                ),

                              ),
                            ),
                          ),
                        ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20, left: leftPadding, right: rightPadding, bottom: 0),
                  //   child: Container(
                  //     constraints: BoxConstraints(maxHeight: 10, ),
                  //     child: ListView.separated(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       itemCount: totalSteps!.toInt(),
                  //       separatorBuilder: (context, index) => const SizedBox(width: separatedWidth,),
                  //       itemBuilder: (context, position) {
                  //         return Container(
                  //           width: (screenWidth - ((totalSteps! - 1) * separatedWidth)
                  //               - (leftPadding + rightPadding)) / totalSteps!,
                  //           decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(20)
                  //           ),
                  //           child: Container(
                  //             height: 2,
                  //             decoration: BoxDecoration(
                  //                 color: currentStep! >= position ? Colors.green : Colors.transparent,
                  //                 borderRadius: BorderRadius.circular(20)
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),


                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ThemeColors.buttonColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Download Invoice",style: TextStyle(fontSize: 18),)

                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("You might be also Interested in"),),

                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }


  Widget unstoppableProductCard() {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyOrdersDetail()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1, color: ThemeColors.buttonColor),
              // color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                // leading: nameIcon(),
                leading: CachedNetworkImage(
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Delivered on Jan 25",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          //color: Theme.of(context).accentColor
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.textFieldBgColor,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "\u{20B9} 15,000",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),

                  ],
                ),

              ),
            ),
          ),
        ));
  }
}