
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unstoppable_customer_app/Screen/Category/brandTab.dart';
import 'package:unstoppable_customer_app/Screen/Category/categoriesTab.dart';
import 'package:unstoppable_customer_app/Widget/drawer.dart';

import '../../Constant/theme_colors.dart';
import '../Home/search_product.dart';

class Category extends StatefulWidget {
  Category({Key? key, }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> with TickerProviderStateMixin{
  List<Tab> _tabs = [];
  // List<ComboPack> mArrayListTab = [];
  List<Widget> _generalWidgets = [];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this)
      ..addListener(_updatePage);
  }
  void _updatePage() {
    setState(() {});
  }
  //Tab helpers
  bool isFirstPage() {
    return _tabController!.index == 0;
  }

  bool isLastPage() {
    return _tabController!.index == _tabController!.length - 1;
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                    "Category",
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
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(Icons.search_sharp,color: Colors.white,),
            )
          ],

          // bottom:   TabBar(
          //   labelColor: Colors.black,
          //   unselectedLabelColor: Colors.black,
          //   indicatorColor: Colors.red,
          //   tabs: [
          //     Tab(
          //       text: "Categories",
          //     ),
          //     Tab(
          //       text: "Brand",
          //     ),
          //     // Tab(icon: Icon(Icons.camera_alt)),
          //     // Tab(icon: Icon(Icons.grade)),
          //     // Tab(icon: Icon(Icons.email)),
          //   ],
          // ),
        ),
        drawer: DrawerWidget(),
        body: CategoriesTab()
        // Scaffold(
        //   appBar: TabBar(
        //     labelColor: Colors.black,
        //     unselectedLabelColor: ThemeColors.textFieldBgColor,
        //     indicatorColor: ThemeColors.buttonColor,
        //     labelStyle: TextStyle(
        //       fontSize: 19,
        //       fontWeight: FontWeight.w500
        //     ),
        //     tabs: [
        //       Tab(
        //         text: "Categories",
        //       ),
        //       Tab(
        //         text: "Brand",
        //       ),
        //       // Tab(icon: Icon(Icons.camera_alt)),
        //       // Tab(icon: Icon(Icons.grade)),
        //       // Tab(icon: Icon(Icons.email)),
        //     ],
        //   ),
        //   body:
        //   TabBarView(
        //     children: [
        //       CategoriesTab(),
        //       BrandTab()
        //     ],
        //   ) ,
        // )

      )
    );
  }

}