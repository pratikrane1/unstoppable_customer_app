

import 'package:flutter/material.dart';
import 'package:unstoppable_customer_app/Screen/Home/home_scree.dart';

import '../../Constant/theme_colors.dart';
import '../../Widget/app_button.dart';
import '../MyOrders/myOrders_Screen.dart';
import '../bottom_navbar.dart';

class ThankYouPage extends StatefulWidget{
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage>{

  @override
  Widget build(BuildContext context){
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
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ThemeColors.baseThemeColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       color: ThemeColors.backgroundColor
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 15.0,top: 10.0,bottom: 10.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text("It's ordered!",
              //           style: TextStyle(
              //             fontFamily: 'SF-Pro-Display-Regular',
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500
              //           ),),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Text("Order No. #12345",
              //             style: TextStyle(
              //                 fontFamily: 'SF-Pro-Display-Medium',
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500
              //             ),),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You've successfully placed the order",
                      style: TextStyle(
                          fontFamily: 'SF-Pro-Display-Regular',
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                      ),),
                      SizedBox(
                        height: 8,
                      ),
                      Text("You can check status of your order in My Orders page.",
                      style: TextStyle(
                        fontFamily: 'SF-Pro-Display-Medium'
                      ),),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:
                            AppButton(
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 3,)));
                              },
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              text: 'SHOW ALL MY ORDERS',
                              loading: true,
                            )
                        ),
                      ),
                      Center(
                        child: Text("OR",
                          style: TextStyle(
                              fontFamily: 'SF-Pro-Display-Regular',
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),),
                      ),
                      InkWell(
                        onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 0,)));
                        },
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("BACK TO HOME",
                                  style: TextStyle(
                                      fontFamily: 'SF-Pro-Display-Regular',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                  ))
                              // AppButton(
                              //   onPressed: () async {
                              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 0,)));
                              //   },
                              //   shape: const RoundedRectangleBorder(
                              //       borderRadius:
                              //       BorderRadius.all(Radius.circular(10))),
                              //   text: 'BACK TO HOME',
                              //   loading: true,
                              // )
                          ),
                        ),
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
}