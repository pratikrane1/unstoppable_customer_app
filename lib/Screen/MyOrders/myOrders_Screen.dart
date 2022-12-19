import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Bloc/myOrders/myOrders_event.dart';
import 'package:unstoppable_customer_app/Screen/MyOrders/myOrderDetail_screen.dart';
import 'package:unstoppable_customer_app/Screen/MyOrders/searchOrder.dart';
import 'package:unstoppable_customer_app/Widget/drawer.dart';

import '../../Bloc/myOrders/myOrders_bloc.dart';
import '../../Bloc/myOrders/myOrders_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/my_order.dart';
import '../../Utils/application.dart';
import '../Home/search_product.dart';

class MyOrders extends StatefulWidget {
  MyOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
   MyOrdersBloc? _myOrdersBloc;
   List<Orders>? myOrderList = [];
  bool isconnectedToInternet = false;
  bool flagNoData = false;
  List<Orders> searchresult = [];
  MyOrdersResp? orderData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // flagNoData = false;
    _myOrdersBloc = BlocProvider.of<MyOrdersBloc>(context);
    _myOrdersBloc!.add(OnLoadingOrdersList(
        userId: Application.customerLogin!.userId.toString()));

  }
  Widget buildOrdersList(BuildContext context, List<Orders> myOrderList) {
    if (myOrderList.length <= 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  // leading: nameIcon(),
                  leading: CachedNetworkImage(
                    filterQuality: FilterQuality.medium,
                    // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                    imageUrl: "https://picsum.photos/250?image=9",
                    // imageUrl: model.cart[index].productImg == null
                    //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
                    //     : model.cart[index].productImg,
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
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Loading...",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            //color: Theme.of(context).accentColor
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                ".......",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
              ),
            ),
          );
        },
        itemCount: List.generate(8, (index) => index).length,
      );
    }

    // return ListView.builder(
    return ListView.builder(
      //shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: myOrderList.length,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyOrdersDetail(myOrderList: myOrderList[index],)));
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
                  padding: const EdgeInsets.only(bottom: 0,left:8,right: 8,top: 0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0,left:8,right: 8,top: 0),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   border: Border.all(width: 1, color: ThemeColors.buttonColor),
                      //   // color: Colors.black12,
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // CachedNetworkImage(
                          //   height: 80,
                          //   width: 85,
                          //
                          //   filterQuality: FilterQuality.medium,
                          //   // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                          //   // imageUrl: "https://picsum.photos/250?image=9",
                          //   imageUrl:"myOrderList.products![0].imgPath.toString()",
                          //
                          //   placeholder: (context, url) {
                          //     return Shimmer.fromColors(
                          //       baseColor: Theme.of(context).hoverColor,
                          //       highlightColor: Theme.of(context).highlightColor,
                          //       enabled: true,
                          //       child: Container(
                          //         height: 80,
                          //         width: 80,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   imageBuilder: (context, imageProvider) {
                          //     return Container(
                          //       height: 80,
                          //       width: 80,
                          //       decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //           image: imageProvider,
                          //           fit: BoxFit.cover,
                          //         ),
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //     );
                          //   },
                          //   errorWidget: (context, url, error) {
                          //     return Shimmer.fromColors(
                          //       baseColor: Theme.of(context).hoverColor,
                          //       highlightColor: Theme.of(context).highlightColor,
                          //       enabled: true,
                          //       child: Container(
                          //         height: 80,
                          //         width: 80,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child: Icon(Icons.error),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 20,
                          // ),
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
                                      myOrderList[index].orderId.toString(),
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
                                  myOrderList[index].orderDate.toString(),
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
                                '\u{20B9} '+ myOrderList[index].subTotal.toString(),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 28, // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Orders",
                    style: TextStyle(color: ThemeColors.whiteTextColor),
                  ),

                  // myAppBarIcon(),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchOrder());
              },
              icon: Icon(Icons.search_sharp,color: Colors.white,),
            )
          ],
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(40),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       width: double.infinity,
          //       height: 40,
          //       color: Colors.white,
          //       child: const Center(
          //         child: TextField(
          //           decoration: InputDecoration(
          //               hintText: 'Search for something',
          //               prefixIcon: Icon(Icons.search),
          //               suffixIcon: Icon(CupertinoIcons.mic_fill)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ),
        drawer: DrawerWidget(),
        body:
        BlocBuilder<MyOrdersBloc, MyOrdersState>(builder: (context, state) {
          if (state is MyOrdersListSuccess) {
            myOrderList = state.orderList!;
            orderData = state.orderData;
          // flagNoData = false;
          }
          if (state is MyOrdersLoading) {
            flagNoData = false;
          }
          if (state is MyOrdersListLoadFail) {
            flagNoData = true;
          }
          return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    child: buildOrdersList(context,myOrderList!),
                  ),
                ) );
        }));
        // body: SingleChildScrollView(
        //   child: Container(
        //     height: MediaQuery.of(context).size.height,
        //     child: Container(
        //       child: buildOrdersList(),
        //     ),
        //   ),
        // ));
  }

  Widget unstoppableProductCard(BuildContext context, List<Orders> myOrderList) {
    return InkWell(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => MyOrdersDetail(myOrderList: myOrderList,)));
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
                    children: [
                      CachedNetworkImage(
                        height: 80,
                        width: 85,

                        filterQuality: FilterQuality.medium,
                        // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                        // imageUrl: "https://picsum.photos/250?image=9",
                       imageUrl:"myOrderList.products![0].imgPath.toString()",

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
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "myOrderList",
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
                          Container(
                            width: MediaQuery.of(context).size.width / 1.9,
                            child: Text(
                              "myOrderList.description.toString()",
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
                            '\u{20B9}'+ "myOrderList.price.toString()",
                            style: TextStyle(
                              fontFamily: 'SF-Pro-Display-Bold',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
