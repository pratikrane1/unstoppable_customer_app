import 'package:flutter/material.dart';
import '../Constant/theme_colors.dart';
import 'app_button.dart';


class CheckoutBottomBar extends StatefulWidget {
  const CheckoutBottomBar({Key? key}) : super(key: key);

  @override
  _CheckoutBottomBarState createState() => _CheckoutBottomBarState();
}

class _CheckoutBottomBarState extends State<CheckoutBottomBar> {
  var mainHeight, mainWidth;
  var cartValue = 2;
  // final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: mainHeight / 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                        'Sub Total',
                          style: TextStyle(
                            fontFamily: "SF-Pro-Display-Bold",
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                      )),
                  Container(
                      child: Text(
                        "00.00",
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                        'Delivery Fee',
                        style: TextStyle(
                          fontFamily: "SF-Pro-Display-Bold",
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      )),
                  Container(
                      child: Text(
                        "00.00",
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
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontFamily: "SF-Pro-Display-Bold",
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "00.00",
                    style: TextStyle(
                      fontFamily: "SF-Pro-Display-Regular",
                      // fontWeight: FontWeight.w700,
                      fontSize: 16.0,
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
                        onPressed: () async {},
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        text: 'Checkout',
                        // loading: login is LoginLoading,
                        disableTouchWhenLoading: true,
                      )
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
