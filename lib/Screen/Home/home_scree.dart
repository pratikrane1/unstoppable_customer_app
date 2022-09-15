import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unstoppable_customer_app/Config/theme.dart';
import 'package:unstoppable_customer_app/Utils/translate.dart';
import 'package:unstoppable_customer_app/app.dart';

import '../../Constant/theme_colors.dart';
import '../../Widget/common.dart';
import '../../Widget/drawer.dart';
import '../../Widget/product_Card.dart';

class HomeScreen extends StatefulWidget {
  int index;

  HomeScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List dummyData = List.generate(10000, (index) => '$index');

  Widget buildCategory() {
    if (dummyData.length <= 0) {
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
      scrollDirection: Axis.horizontal,

      itemBuilder: (context, index) {
        // final item = producerList[index];
        return Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
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
                      imageUrl: "https://picsum.photos/250?image=9",
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        "fght",
                        style: TextStyle(
                            fontFamily: 'SF-Pro-Display',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                            color: Colors.black),
                      ),
                    )
                  ],
                )));
      },
      itemCount: 10,
    );
  }

  Widget buildListViewItemProd() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index)
    {
      return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
              padding: EdgeInsets.only(left: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CachedNetworkImage(
                        width: 100,
                        height: 100,
                        filterQuality: FilterQuality.medium,
                        // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                        // imageUrl: "https://picsum.photos/250?image=9",
                        imageUrl: "https://picsum.photos/250?image=9",
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Theme
                                .of(context)
                                .hoverColor,
                            highlightColor: Theme
                                .of(context)
                                .highlightColor,
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
                            baseColor: Theme
                                .of(context)
                                .hoverColor,
                            highlightColor: Theme
                                .of(context)
                                .highlightColor,
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
                              Text(
                                "High speed table fan for home",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ThemeColors.textFieldBgColor,
                                  fontSize: 10.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                      )
                    ],
                  ),
                ),
              ))
        // }
      );
    });
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
                  "Hi OM",
                  style: TextStyle(color: ThemeColors.whiteTextColor),
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // slider images in row
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, right: 8.0, left: 5.0),
                child: Container(
                    width: double.infinity,
                    height: 100,
                    child: buildCategory()),
              ),
              imageSlider(),

                  buildProductCard()

            ],
          ),
        ),
      ),
    );
  }
}

Widget buildProductCard() {
  return Padding(
    padding: const EdgeInsets.only(left:8.0,right: 8.0),
    child: GridView.count(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(10, (index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                width: 100,
                height: 100,
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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "High speed table fan for home",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.textColor,
                          fontSize: 12.0,
                          fontFamily: 'SF-Pro-Display'
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\u{20B9} 15,000",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          fontFamily: 'SF-Pro-Display'
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    ),
  );
}
