import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../Constant/font_size.dart';
import '../../Constant/theme_colors.dart';
import '../../Widget/fixed_checkout_bottom_bar.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  // bool backIcon;
  CartPage({Key? key,
    // required this.backIcon
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
  bool backIcon = false;

  @override
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: CheckoutBottomBar( total: prodValue, value: quantity,),
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
          child: backIcon ?
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: "https://picsum.photos/250?image=9",
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
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/farmhouse.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error),
              ),
              title: Text(
                "Product",
                style: TextStyle(
                  fontFamily: "SF-Pro-Display-Bold",
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),

              subtitle: Text(
                  "\u{20B9} $prodValue x $quantity",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: ThemeColors.greyTextColor
                        .withOpacity(0.7),
                    fontSize: 12.0,
                    fontFamily: 'SF-Pro-Display-Regular'),
              ),

              trailing: Container(
                width: mainWidth / 3,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if(quantity>0) {
                            quantity--;
                            totalValue = prodValue * quantity;

                          }
                          // var qty = cert.cart[index].qty! - 1;
                          // cert.updateProduct(
                          //     cert.cart[index].id,
                          //     cert.cart[index].price.toString(),
                          //     qty);
                        });
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                          totalValue = prodValue * quantity;

                          // var qty = cert.cart[index].qty! + 1;
                          // cert.updateProduct(
                          //     cert.cart[index].id,
                          //     cert.cart[index].price.toString(),
                          //     qty);
                        });
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: ThemeColors.baseThemeColor,
                      ),
                    ),
                  ],
                ),
              ),

              //trailing:Add_to_cart_column(),
            );
          },
        ),
      ),
    );
  }
}
