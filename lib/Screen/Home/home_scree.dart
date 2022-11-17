import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Config/theme.dart';
import 'package:unstoppable_customer_app/Model/banner_model.dart';
import 'package:unstoppable_customer_app/Model/category_list.dart';
import 'package:unstoppable_customer_app/Model/product_model.dart';
import 'package:unstoppable_customer_app/Screen/Home/product_details.dart';
import 'package:unstoppable_customer_app/Utils/translate.dart';
import 'package:unstoppable_customer_app/app.dart';

import '../../Bloc/home/home_bloc.dart';
import '../../Bloc/home/home_event.dart';
import '../../Bloc/home/home_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Widget/common.dart';
import '../../Widget/drawer.dart';
import '../../Widget/product_Card.dart';
import '../Cart/cart.dart';
import '../bottom_navbar.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List dummyData = List.generate(10000, (index) => '$index');

  HomeBloc? _homeBloc;
  List<ProductModel>? productList = [];
  List<BannerModel>? bannerList = [];
  List<CategoryModel>? categoryList = [];

  initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc!.add(GetHomeCategory(perPage: '5', startFrom: '1'));
    _homeBloc!.add(GetProduct(limit: '10'));
    _homeBloc!.add(GetBanners());
  }

  Future<Null> _onRefresh() {
    setState(() {
      _homeBloc!.add(GetHomeCategory(perPage: '5', startFrom: '1'));
      _homeBloc!.add(GetProduct(limit: '10'));
      _homeBloc!.add(GetBanners());    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }

  Widget buildCategory(BuildContext context, List<CategoryModel> categoryList) {
    if (categoryList.length <= 0) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.21,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.white,
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      Translate.of(context)!.translate('loading'),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
      itemBuilder: (context, index) {
        // final item = producerList[index];
        return Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryScreen(catData: categoryList[index])));
                  // print('clicked category');
                  // setState(() {
                  //   producerListIndex = index;
                  //   type=index==0?"ALL":"";
                  //   flagNoData=false;
                  //   productLists=[];
                  //
                  // });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${categoryList[index].ssCatImg}",
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(40))
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Theme.of(context).hoverColor,
                          highlightColor: Theme.of(context).highlightColor,
                          enabled: true,
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(35),
                            //   ),
                            // ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Shimmer.fromColors(
                          baseColor: Theme.of(context).hoverColor,
                          highlightColor: Theme.of(context).highlightColor,
                          enabled: true,
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(35),
                            //   ),
                            // ),
                            child: Icon(Icons.error),
                          ),
                        );
                      },
                    ),
                    Container(
                      width: 70,
                      // padding: EdgeInsets.all(5),
                      child: Text(
                        "${categoryList[index].ssCatName}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'SF-Pro-Display',
                            fontWeight: FontWeight.w600,
                            fontSize: 11.0,
                            color: Colors.black),
                      ),
                    )
                  ],
                )));
      },
      itemCount: categoryList.length,
    );
  }



  Widget buildProductList(
      BuildContext context, List<ProductModel> productList) {
    if (productList.length <= 0) {
      return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/2.5,
        ),
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
                        imageUrl: "https://picsum.photos/250?image=9",
                        // imageUrl: productData.prodImg.toString(),
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
                                "Product",
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
                                "\u{20B9} 0.0",
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
                                    "\u{20B9} 0.0",
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
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        childAspectRatio: 2/2.5,
      ),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return buildProductCard(context, productList[index]);
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
                        "\u{20B9} ${productData.price}",
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


  Widget buildBannerList(
      BuildContext context, List<BannerModel> bannerList) {
    if (bannerList.length <= 0) {
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
        itemCount: List.generate(2, (index) => index).length,
      );
    }

    // return ListView.builder(
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return BannerCard(context, bannerList);
      },
      itemCount: bannerList.length,
    );
  }

  Widget BannerCard(BuildContext context, List<BannerModel> bannerList){
    return Container(
      margin: EdgeInsets.all(15),
      child: CarouselSlider.builder(
        itemCount: bannerList.length,
        options: CarouselOptions(
          enlargeCenterPage: true,
          height: 300,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          reverse: false,
          aspectRatio: 5.0,
        ),
        itemBuilder: (context, i, id){
          //for onTap to redirect to another screen
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white,)
              ),
              //ClipRRect for image border radius
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  bannerList[0].bannerImg.toString(),
                  width: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: (){
              // var url = imageList[i];
              // print(url.toString());
            },
          );
        },
      ),
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
                  "Unstoppable",
                  style: TextStyle(color: ThemeColors.whiteTextColor,fontFamily: 'Poppins-SemiBold',),
                ),
                notificationIcon(context),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
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
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is GetCategorySuccess){
                  categoryList = state.categoryList;
                }
                if(state is GetCategoryfail){
                  Fluttertoast.showToast(msg: state.message);
                }
                if (state is ProductLoading) {
                  // profileData = [];
                  // setData(companyData!);
                }
                if (state is ProductSuccess) {
                  productList = state.productData;
                  // setData(companyData!);
                }
                if (state is Productfail) {
                  // profileData = [];
                  // setData(companyData!);
                }
                if(state is GetBannerSuccess){
                  bannerList = state.bannerList;
                }
                if(state is GetBannerfail){
                  Fluttertoast.showToast(msg: "Banner Load Fail");
                }
              },
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // slider images in row
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 8.0, left: 5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Poppins-SemiBold',
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 2,)));
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 7,
                                child: buildCategory(context, categoryList!)),
                          ],
                        ),
                      ),
                      // imageSlider(),

                      // buildBannerList(context, bannerList!),

                      (bannerList!.isEmpty)
                          ? Container()
                          :
                      Container(
                        margin: EdgeInsets.all(15),
                        child: CarouselSlider.builder(
                          itemCount: bannerList!.length,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 250,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            reverse: false,
                            aspectRatio: 5.0,
                          ),
                          itemBuilder: (context, i, id){
                            //for onTap to redirect to another screen
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.white,)
                                ),
                                //ClipRRect for image border radius
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    bannerList![0].bannerImg.toString(),
                                    width: 500,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: (){
                                // var url = imageList[i];
                                // print(url.toString());
                              },
                            );
                          },
                        ),
                      ),

                      buildProductList(context, productList!)
                    ],
                  ),
                ),
              )

              // Center(
              //   child: CircularProgressIndicator(),
              // )

              );
        }),
      ),
    );
  }
}


