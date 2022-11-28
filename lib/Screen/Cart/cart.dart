import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Bloc/cart/cart_bloc.dart';
import '../../Bloc/cart/cart_event.dart';
import '../../Bloc/cart/cart_state.dart';
import '../../Constant/font_size.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/cart_model.dart';
import '../../Utils/application.dart';
import '../../Widget/app_button.dart';
import '../../Widget/fixed_checkout_bottom_bar.dart';
import 'package:shimmer/shimmer.dart';

import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  bool backIcon;
  CartPage({Key? key,
    required this.backIcon
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var mainHeight, mainWidth;
  // final cartController = Get.put(CartController());
  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;


  CartBloc? _cartBloc;
  List<CartListModel> cartList = [];
  dynamic cartData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _cartBloc!.add(GetCart(user_id: Application.customerLogin!.userId.toString()));
  }

  Future<Null> _onRefresh() {
    setState(() {
      _cartBloc!.add(GetCart(user_id: Application.customerLogin!.userId.toString()));
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }



  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomNavigationBar: cartData != null ? BottomBar(context, cartData) : Container(),
        appBar: AppBar(
            title: Text(
              "Cart",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'SF-Pro-Display-Regular',
                  color: ThemeColors.whiteTextColor
              ),
            ),
            backgroundColor: ThemeColors.baseThemeColor,
            centerTitle: true,
            elevation: 0.0,
            leading: Container(
                child: widget.backIcon ?
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )) : Container()
            )

        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            return BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartListSuccess) {
                  cartList = state.cartList;
                  cartData = state.cartData;
                }
                if (state is CartListLoading) {
                  // loading = false;
                }
                if (state is CartListfail) {
                  Fluttertoast.showToast(
                      msg: state.message.toString());
                  // loading = false;
                }
                if(state is DeleteCartSuccess){
                  Fluttertoast.showToast(
                      msg: state.message.toString());
                  _cartBloc!.add(GetCart(user_id: Application.customerLogin!.userId.toString()));

                }
                if(state is DeleteCartfail){
                  Fluttertoast.showToast(
                      msg: state.message.toString());
                }

              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: cartList.isNotEmpty ? cartList.length > 0 ?
                    ListView(
                      children: [
                        CartList(context, cartList),
                      ],
                    ):
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Cart is empty",
                        style: TextStyle(
                          fontFamily: "SF-Pro-Display-Bold",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),),
                    )
                        :
                    ListView.builder(
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
                      itemCount: List.generate(4, (index) => index).length,
                    ),

                  ),
                  cartData != null ?
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomBar(context, cartData, cartList))
                      : Container(),
                ],
              ),

              // Center(
              //   child: CircularProgressIndicator(),
              // )


            );
          }
          )

        )

    )
      ;

  }

  Widget CartList(BuildContext context, List<CartListModel> cartList){

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: "${cartList[index].prodImg}",
            imageBuilder: (context, imageProvider) =>
                Container(
                  height: mainWidth / 5,
                  width: mainWidth / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
              child: Container(
                height: mainWidth / 5,
                width: mainWidth / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          ),
          title: Text(
            cartList[index].prodName.toString(),
            style: TextStyle(
              fontFamily: "SF-Pro-Display-Bold",
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),

          subtitle: Text(
            "\u{20B9} ${cartList[index].price} x ${cartList[index].quantity} = \u{20B9} ${cartList[index].subTotal}",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: ThemeColors.greyTextColor
                    .withOpacity(0.7),
                fontSize: 12.0,
                fontFamily: 'SF-Pro-Display-Regular'),
          ),

          trailing: Container(
            // width: mainWidth / 3,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                _cartBloc!.add(DeleteCart(
                    user_id: Application.customerLogin!.userId.toString(),
                    prod_id: cartList[index].prodId.toString()));
              },
            ),


          ),

          //trailing:Add_to_cart_column(),
        );
      },
    );
  }

  Widget BottomBar(BuildContext context,CartListRepo cartData,List<CartListModel> cartList) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            color: ThemeColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: mainHeight / 4.5,
        child: Column(
          children: [
            //SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                        'Products',
                        style: TextStyle(
                          fontFamily: "SF-Pro-Display-Bold",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      )),
                  Container(
                      child: cartData.cartQuantity == "" ?
                      Text("x0",
                        style: TextStyle(
                          fontFamily: "SF-Pro-Display-Regular",
                          // fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ) : Text(cartData.cartQuantity.toString(),
                        style: TextStyle(
                          fontFamily: "SF-Pro-Display-Regular",
                          // fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      )
                  ),
                ],
              ),
            ),
            //SizedBox(height: 5,),
            // Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping charges: ',
                    style: TextStyle(
                      fontFamily: "SF-Pro-Display-Bold",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                  Container(
                    child: cartData.shippingCharge == "" ?
                    Text("\u{20B9} 0",
                      style: TextStyle(
                        fontFamily: "SF-Pro-Display-Regular",
                        // fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ) : Text("\u{20B9} ${cartData.shippingCharge}",
                      style: TextStyle(
                        fontFamily: "SF-Pro-Display-Regular",
                        // fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontFamily: "SF-Pro-Display-Bold",
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  Container(
                    child: cartData.cartTotal == "" ?
                    Text("\u{20B9} 0",
                      style: TextStyle(
                        fontFamily: "SF-Pro-Display-Regular",
                        // fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ) : Text("\u{20B9} ${cartData.cartTotal}",
                      style: TextStyle(
                        fontFamily: "SF-Pro-Display-Regular",
                        // fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ), // SizedBox(height: 10,),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: mainWidth,
                height: 60,
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      AppButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage(cartList: cartList,cartData: cartData,)));
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        text: 'Checkout',
                        loading: true,
                      )
                  ),
                ),
              ),
            ),
          ],
        ));
  }


}
