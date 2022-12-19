import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Model/address_model.dart';
import 'package:unstoppable_customer_app/Screen/Cart/thankyou_screen.dart';

import '../../Api/api.dart';
import '../../Bloc/address/address_event.dart';
import '../../Bloc/cart/cart_bloc.dart';
import '../../Bloc/cart/cart_event.dart';
import '../../Bloc/cart/cart_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/cart_model.dart';
import '../../Utils/application.dart';
import '../../Utils/application.dart';
import '../../Utils/application.dart';
import '../../Widget/app_button.dart';
import 'package:http/http.dart' as http;
import '../Profile/address_page.dart';
import '../Profile/address_page_profile.dart';
import '../bottom_navbar.dart';

class CheckOutPage extends StatefulWidget {
  List<CartListModel> cartList;
  CartListRepo cartData;
  CheckOutPage({Key? key, required this.cartList, required this.cartData})
      : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var mainHeight, mainWidth;

  int? typeId = 1;
  String? radioBtnType;
  AddressModel? addressData;
  CartBloc? _cartBloc;
  Timer? timer;
  String _mid = "ctqcfC52960494856707"; //live mid=GXytVC30838085377757
  double? amount = 100;


  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    print(widget.cartList);
    print(widget.cartData);

    if (Application.address != null) {
      Application.address!.streetAddress.toString();
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>addValue());
    }
    _onRefresh();
    super.initState();
  }

  void addValue() {
    setState(() {
      EditAddress();
      // AddAddress(
      //   user_id: Application.customerLogin!.userId.toString(),
      //   city: Application.address!.city.toString(),
      //   pinCode: Application.address!.pincode.toString(),
      //   state: Application.address!.state.toString(),
      //   streetAddress: Application.address!.streetAddress.toString(),
      // );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> showAlert() async {
    showDialog(context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Address"),
            content: const Text("Do you want to add address?"),
            actions: [
              ElevatedButton(onPressed: (){
                _onRefresh();
                Navigator.of(context).pop();
              }, child: const Text("Yes"))
            ],
          );
        }
    );



  }

  Widget EditAddress()
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Application.address == null
                  ? Container(
                // child:  InkWell(
                //   onTap: (){
                //     showAlert();
                //     // Application.address != null && Application.address!.id != null
                //     // ?showAlert()
                //     //     :Container();
                //
                //   },
                //     //child: Icon(Icons.refresh)),
                //   child: Text("Add address")),
              )
                  : Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.maps_home_work_outlined),
                  SizedBox(
                    width: 20,
                  ),
                  Application.address!.id != null
                      ? Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${Application.address!.streetAddress}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily:
                            'SF-Pro-Display-Regular',
                            fontWeight:
                            FontWeight.w500),
                      ),
                      Text(
                          "${Application.address!.city},${Application.address!.state},${Application.address!.pincode}"),
                    ],
                  )
                      : Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily:
                            'SF-Pro-Display-Regular',
                            fontWeight:
                            FontWeight.w500),
                      ),
                      Text(""),
                    ],
                  )
                ],
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressProfile(cartData: widget.cartData, cartList: widget.cartList,)));
                        //  Navigator.pushAndRemoveUntil(
                        //      context,
                        //      MaterialPageRoute(
                        //          builder: (context) =>
                        //              Address()),
                        //          (Route<dynamic> route) =>
                        //      false);
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
                      text: Application.address == null
                          ? 'Choose Address'
                          : 'Edit Address',
                      loading: true,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _onRefresh() {
    setState(() {
      if (Application.address != null) {
        Application.address!.streetAddress.toString();
      }
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }

  Future<void> generateTxnToken(double amount) async {
    Map<String, String> params = {
      "amount": amount.toString(),
      "customer_id": Application.customerLogin!.userId.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(Api.GENERATE_TOKEN),
        body: params,
        // headers: {'Content-type': "application/json"},
      );
      var resp = jsonDecode(response.body);

      final callBackUrl =
          'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=' +
              resp['order_id'].toString();
      await initiateTransaction(
          resp['order_id'], amount, resp['txnToken'], callBackUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> initiateTransaction(String orderId, double amount,
      String txnToken, String callBackUrl) async {
    String result = '';
    try {
      var response = AllInOneSdk.startTransaction(
        _mid,
        orderId,
        amount.toString(),
        txnToken,
        callBackUrl,
        true,
        true,
      );
      response.then((value) {
        // Transaction successfull
        print(value);
        Fluttertoast.showToast(msg: "Payment done successfully");
        Navigator.pop(context);
      }).catchError((onError) {
        if (onError is PlatformException) {
          // result = onError.message! + " \n  " + onError.details.toString();
          result = onError.message! + " \n  " + onError.details.toString();
          Fluttertoast.showToast(msg: "Payment cancelled successfully");

          print(result);
        } else {
          result = onError.toString();
          print(result);
        }
      });
    } catch (err) {
      // Transaction failed
      result = err.toString();
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'SF-Pro-Display-Regular',
              color: ThemeColors.whiteTextColor
          ),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 0,)));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),

      body: RefreshIndicator(
        onRefresh: _onRefresh,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 10),
                      child: Text(
                        "Delivery Address",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SF-Pro-Display-Regular',
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    //

                    EditAddress(),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Payment Type",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SF-Pro-Display-Regular',
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // _atomaticManualOther(),
                                  // _semiatomaticMultiporpose(),
                                  Radio(
                                    value: 1,
                                    groupValue: typeId,
                                    onChanged: (val) {
                                      setState(() {
                                        radioBtnType = 'COD';
                                        typeId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Cash on Delivery (COD)',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'SF-Pro-Display-Regular',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: typeId,
                                    onChanged: (val) {
                                      setState(() {
                                        radioBtnType = 'PayTM';
                                        typeId = 2;
                                      });
                                    },
                                  ),
                                  Image.asset(
                                    "assets/images/paytm-icon.png",
                                    height: 70,
                                    width: 50,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Order Summary",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SF-Pro-Display-Regular',
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4.2,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          CartList(context, widget.cartList),
                        ],
                      ),
                    ),
                  ],
                )
            ),


            widget.cartData != null ?
            Align(
                alignment: Alignment.bottomCenter,
                child:
                    BottomBar(context, widget.cartData, widget.cartList))
            : Container(),
          ],
        ),
      ),
    );
  }

  Widget CartList(BuildContext context, List<CartListModel> cartList) {
    if (cartList.length <= 0) {
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
        itemCount: List.generate(4, (index) => index).length,
      );
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: "${cartList[index].prodImg}",
            imageBuilder: (context, imageProvider) => Container(
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
            errorWidget: (context, url, error) => Icon(Icons.error),
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
                color: ThemeColors.greyTextColor.withOpacity(0.7),
                fontSize: 12.0,
                fontFamily: 'SF-Pro-Display-Regular'),
          ),

          //trailing:Add_to_cart_column(),
        );
      },
    );
  }

  Widget BottomBar(BuildContext context, CartListRepo cartData,
      List<CartListModel> cartList) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            color: ThemeColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: mainHeight / 4.8,
        width: double.infinity,
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
                      child: cartData.cartQuantity == ""
                          ? Text(
                              "x0",
                              style: TextStyle(
                                fontFamily: "SF-Pro-Display-Regular",
                                // fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            )
                          : Text(
                              cartData.cartQuantity.toString(),
                              style: TextStyle(
                                fontFamily: "SF-Pro-Display-Regular",
                                // fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            )),
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
                    child: cartData.shippingCharge == ""
                        ? Text(
                            "\u{20B9} 0",
                            style: TextStyle(
                              fontFamily: "SF-Pro-Display-Regular",
                              // fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          )
                        : Text(
                            "\u{20B9} ${cartData.shippingCharge}",
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
              padding: const EdgeInsets.only(bottom: 3.0),
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
                    child: cartData.cartTotal == ""
                        ? Text(
                            "\u{20B9} 0",
                            style: TextStyle(
                              fontFamily: "SF-Pro-Display-Regular",
                              // fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                            ),
                          )
                        : Text(
                            "\u{20B9} ${cartData.cartTotal}",
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
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              return BlocListener<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CheckOutSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThankYouPage()));
                    Fluttertoast.showToast(msg: state.message.toString());
                  }
                  if (state is CheckOutLoading) {
                    // loading = false;
                  }
                  if (state is CheckOutfail) {
                    Fluttertoast.showToast(msg: state.message.toString());
                    // loading = false;
                  }
                },
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: mainWidth,
                    height: 60,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppButton(
                            onPressed: () async {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage(cartList: cartList,cartData: cartData,)));
                              if (typeId == 2) {
                                generateTxnToken(amount!);
                              } else {
                                _cartBloc!.add(CheckOut(
                                  user_id: Application.customerLogin!.userId
                                      .toString(),
                                  subTotal: widget.cartData.cartTotal,
                                  totalAmount: widget.cartData.cartTotal,
                                  shippingCharge:
                                      widget.cartData.shippingCharge,
                                  paymentMethod: typeId.toString(),
                                  address: Application.address!.streetAddress
                                          .toString() +
                                      ',' +
                                      Application.address!.city.toString() +
                                      ',' +
                                      Application.address!.state.toString() +
                                      ',' +
                                      Application.address!.pincode.toString(),
                                  cart: widget.cartList,
                                ));
                              }
                            },
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            text: 'Proceed to buy',
                            loading: true,
                          )),
                    ),
                  ),
                ),
              );
            })
          ],
        ));
  }
}


