
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hi OM", style: TextStyle(color: ThemeColors.whiteTextColor),),
                notificationIcon(),
              ],
            ),
          ],
        ),
        bottom: 
        PreferredSize(
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
      body: ListView(
        children: [
          // slider images in row
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 8.0,left: 35.0),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyData.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 50,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: Container(
                            color: Colors.blue[200],
                            alignment: Alignment.center,
                            child: Text(dummyData[index])));
                  },
                ),
              ),),
          ),
          imageSlider(),
          //  buildBrandList(),
          // SafeArea(
          //   child: SizedBox(
          //     height: double.infinity,
          //     // height: 60,
          //     child: GridView.count(
          //       physics: NeverScrollableScrollPhysics(),
          //       shrinkWrap: true,
          //       // Create a grid with 2 columns. If you change the scrollDirection to
          //       // horizontal, this produces 2 rows.
          //       crossAxisCount: 2,
          //       // Generate 100 widgets that display their index in the List.
          //       children: List.generate(10, (index) {
          //         return Card(
          //           elevation: 4,
          //           child: Center(
          //               child: CachedNetworkImage(
          //                 filterQuality: FilterQuality.medium,
          //                 // imageUrl: Api.PHOTO_URL + widget.users.avatar,
          //                 // imageUrl: "https://picsum.photos/250?image=9",
          //                 imageUrl: "https://picsum.photos/250?image=9",
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
          //               )
          //           ),
          //         );
          //       }),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

}


class HomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height ,

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildBrandList(),
          ),
        ),
      );


  }
}
Widget buildBrandList(){
  return SizedBox(
    height: double.infinity,
   // height: 60,
    child: GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(10, (index) {
        return Card(
          elevation: 4,
          child: Center(
              child: CachedNetworkImage(
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
              )
          ),
        );
      }),
    ),
  );
}