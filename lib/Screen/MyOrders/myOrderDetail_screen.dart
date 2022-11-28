
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../Bloc/myOrders/myOrders_bloc.dart';
import '../../Bloc/myOrders/myOrders_event.dart';
import '../../Bloc/myOrders/myOrders_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/my_order.dart';
import '../../Model/product_model.dart';
import '../../Utils/application.dart';
import '../../Widget/app_button.dart';
import '../Cart/cart.dart';
import '../Home/product_details.dart';
import '../Login/sign_in.dart';

class MyOrdersDetail extends StatefulWidget {
  Orders myOrderList;
  MyOrdersDetail({Key? key,required this.myOrderList}) : super(key: key);

  @override
  State<MyOrdersDetail> createState() => _MyOrdersDetailState();
}

class _MyOrdersDetailState extends State<MyOrdersDetail> {

  MyOrdersBloc? _myOrdersBloc;
  List<Orders>? myOrderList = [];
  bool isconnectedToInternet = false;
  bool flagNoData = false;
  List<Orders> searchresult = [];
  MyOrdersResp? data;
  MyOrdersResp? orderData;
  bool flagNoDataAvailable=false;
  List<ProductModel>? productList = [];

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // flagNoData = false;
    _myOrdersBloc = BlocProvider.of<MyOrdersBloc>(context);
    _myOrdersBloc!.add(OnLoadingOrdersList(
        userId: Application.customerLogin!.userId.toString()));
    // _myOrdersBloc!.add(GetProduct(
    //     sscatId: widget.myOrderList.products[].sscatId.toString()));
    // print(widget.myOrderList.products?.prodName.toString());
  }
  @override
    Widget build(BuildContext context) {

      Widget buildOrdersList(BuildContext context, List<ProductModel> productList,) {
        if (productList.length <= 0) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
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
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(top: 10, bottom: 15),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(productData: productData,)));
              },
              child: Container(
                height: 500,
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
                        imageUrl: productList[index].prodImg.toString(),
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
                                productList[index].prodImg.toString(),
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
                                "\u{20B9} ${productList[index].discountPrice}",
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
                                    "\u{20B9} ${productList[index].price}",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                        fontFamily: 'SF-Pro-Display-Regular',
                                        color: ThemeColors.textFieldHintColor),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CartPage()));
                                      },
                                      child: Icon(
                                        Icons.add_shopping_cart,
                                        color: ThemeColors.baseThemeColor,
                                      ))
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
           // return buildProductCard(context, productList[index]);
           //  return ListView.builder(
           //    scrollDirection: Axis.horizontal,
           //    itemCount: 12,
           //    itemBuilder: (context, index) {
           //      return Card(
           //        semanticContainer: true,
           //
           //        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           //        elevation: 5,
           //        child: Column(
           //
           //          children: [
           //            SizedBox(
           //              height: 20,
           //            ),
           //            CachedNetworkImage(
           //              width: 150,
           //              height: 150,
           //              filterQuality: FilterQuality.medium,
           //              // imageUrl: Api.PHOTO_URL + widget.users.avatar,
           //              // imageUrl: "https://picsum.photos/250?image=9",
           //              imageUrl: productList[index].imgPath,
           //              placeholder: (context, url) {
           //                return Shimmer.fromColors(
           //                  baseColor: Theme.of(context).hoverColor,
           //                  highlightColor: Theme.of(context).highlightColor,
           //                  enabled: true,
           //                  child: Container(
           //                    height: 80,
           //                    width: 80,
           //                    decoration: BoxDecoration(
           //                      color: Colors.white,
           //                      borderRadius: BorderRadius.circular(8),
           //                    ),
           //                  ),
           //                );
           //              },
           //              imageBuilder: (context, imageProvider) {
           //                return Container(
           //                  height: 80,
           //                  width: 80,
           //                  decoration: BoxDecoration(
           //                    image: DecorationImage(
           //                      image: imageProvider,
           //                      fit: BoxFit.cover,
           //                    ),
           //                    borderRadius: BorderRadius.circular(8),
           //                  ),
           //                );
           //              },
           //              errorWidget: (context, url, error) {
           //                return Shimmer.fromColors(
           //                  baseColor: Theme.of(context).hoverColor,
           //                  highlightColor: Theme.of(context).highlightColor,
           //                  enabled: true,
           //                  child: Container(
           //                    height: 80,
           //                    width: 80,
           //                    decoration: BoxDecoration(
           //                      color: Colors.white,
           //                      borderRadius: BorderRadius.circular(8),
           //                    ),
           //                    child: Icon(Icons.error),
           //                  ),
           //                );
           //              },
           //            ),
           //            Padding(
           //              padding: const EdgeInsets.all(15.0),
           //              child: Container(
           //
           //                child: Column(
           //                  crossAxisAlignment: CrossAxisAlignment.start,
           //                  children: [
           //                    Text(widget.myOrderList.prodName.toString(), style: TextStyle(
           //                        fontSize: 12,
           //                        fontFamily: 'SF-Pro-Display-Bold',
           //                        fontWeight: FontWeight.bold
           //                    ),),
           //                    SizedBox(
           //                      height: 5,
           //                    ),
           //                    Container(
           //                      width: MediaQuery.of(context).size.width/2.5,
           //                      child: Text(
           //                        widget.myOrderList.description.toString(),
           //                        style: TextStyle(
           //                          fontFamily: 'SF-Pro-Display-Regular',
           //                          fontWeight: FontWeight.w500,
           //                          color: ThemeColors.greyTextColor.withOpacity(0.7),
           //                          fontSize: 10.0,
           //                        ),
           //                        maxLines: 3,
           //
           //                      ),
           //                    ),
           //                    // Text(
           //                    //   "Neque porro quisquam est qui dolorem\n ipsum quia dolor sit amet, consectetur,\n adipisci velit...",
           //                    //
           //                    //   style: TextStyle(
           //                    //       fontWeight: FontWeight.w500,
           //                    //       color: ThemeColors.greyTextColor.withOpacity(0.7),
           //                    //       fontSize: 10.0,
           //                    //       fontFamily: 'SF-Pro-Display-Regular'
           //                    //   ),
           //                    // ),
           //                    SizedBox(
           //                      height: 5,
           //                    ),
           //                    Text(
           //                      "\u{20B9}"+widget.myOrderList.price.toString(),
           //                      style: TextStyle(
           //                          fontWeight: FontWeight.bold,
           //                          fontSize: 18.0,
           //                          fontFamily: 'SF-Pro-Display-Bold'
           //                      ),
           //                    ),
           //                  ],
           //                ),
           //              ),
           //            )
           //
           //
           //          ],
           //        ),
           //      );
           //
           //    },
           //  );
          },
          itemCount: productList.length,
        );
      }

      Widget buildProductCard(BuildContext context, ProductModel productData) {
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(productData: productData,)));
          },
          child: Container(
            height: 500,
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
                    imageUrl: productData.prodImg.toString(),
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
                            productData.prodName.toString(),
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
                            "\u{20B9} ${productData.discountPrice}",
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
                                "\u{20B9} ${productData.price}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                    fontFamily: 'SF-Pro-Display-Regular',
                                    color: ThemeColors.textFieldHintColor),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CartPage()));
                                  },
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: ThemeColors.baseThemeColor,
                                  ))
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
      }

      Widget buildInterestedCard(BuildContext context, Orders myOrderList){
        return
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 12,
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
                      imageUrl: "widget.myOrderList.imgPath.toString()",
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
                            Text("widget.myOrderList.prodName.toString()", style: TextStyle(
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
                                "widget.myOrderList.description.toString()",
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
                              "\u{20B9}",
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
        body:
        BlocBuilder<MyOrdersBloc, MyOrdersState>(builder: (context, state) {
        if (state is MyOrdersDetailSuccess) {
          myOrderList = state.orderList!;
          data = state.data;
          // flagNoData = false;
        }
        if (state is MyOrdersDetailLoading) {
          flagNoData = false;
        }
        if (state is MyOrdersDetailLoadFail) {
          flagNoData = true;
        }
        if (state is ProductLoading) {
          flagNoDataAvailable = false;
          // profileData = [];
          // setData(companyData!);
        }
        if (state is ProductSuccess) {
          productList = state.productData;
          // setData(companyData!);
        }
        if (state is Productfail) {
          flagNoDataAvailable = true;
          // profileData = [];
          // setData(companyData!);
        }
        if(state is CancelOrderSuccess){
          Fluttertoast.showToast(msg: "Cancel Order successfully");
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 1)));
           Navigator.pop(context);
        }
       return SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MyOrderCard(context, widget.myOrderList,  ),
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
                  SizedBox(height: 10,),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        AppButton(
                          onPressed: () async {
                            _myOrdersBloc!.add(CancelOrder(userId: Application.customerLogin!.userId.toString(),orderId:""));
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          text: 'Cancel Order',
                          // loading: login is LoginLoading,
                          disableTouchWhenLoading: true,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 // OrderStatusCard(context),
                  SizedBox(
                    height: 10,
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

                          child: buildOrdersList(context, productList!, ),
                        )
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        );

        }));
    }

   
// MyOrderCard
  Widget MyOrderCard(BuildContext context, Orders myOrderList) {
    return Container(
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
                Text("",
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
                      imageUrl:"myOrderList.imgPath.toString()",
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
                            "",
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
                            "",
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
                          "\u{20B9}",
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
    );
  }

  Widget OrderStatusCard(BuildContext context)
  {
    int _currentStep = 0;
    StepperType stepperType = StepperType.vertical;
    return  Container(
      child: Column(
        children: [
          Expanded(
            child: Stepper(
              type: stepperType,
              physics: ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue:  continued,
              onStepCancel: cancel,
              steps: <Step>[
                Step(
                  title: new Text('Ordered'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: '23-09-2022'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0 ?
                  StepState.complete : StepState.disabled,
                ),
                Step(
                  title: new Text('Packed'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: '23-09-2022'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Postcode'),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1 ?
                  StepState.complete : StepState.disabled,
                ),
                Step(
                  title: new Text('Shipped'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Mobile Number'),
                      ),
                    ],
                  ),
                  isActive:_currentStep >= 0,
                  state: _currentStep >= 2 ?
                  StepState.complete : StepState.disabled,
                ),
                Step(
                  title: new Text('Delivered'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: '23-09-2022'),
                      ),
                    ],
                  ),
                  isActive:_currentStep >= 0,
                  state: _currentStep >= 2 ?
                  StepState.complete : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
//
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
}


