import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unstoppable_customer_app/Screen/contactUs.dart';
import '../Screen/Login/sign_in.dart';
import '../Screen/bottom_navbar.dart';
import '../Screen/change_password.dart';
import '../Utils/application.dart';
import '../constant/theme_colors.dart';
import 'app_button.dart';

class DrawerWidget extends StatefulWidget {

  DrawerWidget({Key? key}):super(key:key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}
class _DrawerWidgetState extends State<DrawerWidget>{


  // CompanyProfileBloc? _companyProbileBloc;
  // List<CompanyProfileModel>? companyData;
  // List<UserProfileModel>? userProfileData;
  //
  // late Future<UserProfileModel> profileData;


  @override
  void initState() {
    super.initState();
    // _companyProbileBloc = BlocProvider.of<CompanyProfileBloc>(context);
    // // _companyProbileBloc!.add(OnLoadingUserProfile(userid: Application.vendorLogin!.userId.toString()));
    // _companyProbileBloc!.add(OnLoadingCompanyProfileList(userid: Application.vendorLogin!.userId.toString()));
    //
    // profileData = getUserProfile();

  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Scaffold(

        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text('More',style: TextStyle(fontFamily: 'SF-Pro_display',fontSize: 16.0,
          fontWeight: FontWeight.w600,color: Colors.white),),
        ),
        body:
        // BlocBuilder<CompanyProfileBloc, CompanyProfileState>(builder: (context, state) {
        //   if (state is CompanyProfileSuccess) {
        //     companyData = state.companyProfileData;
        //     // setData(companyData!);
        //   }
        //
        //
        //   if(state is CompanyProfileListLoadFail){
        //     companyData=[];
        //     // setData(companyData!);
        //   }
        //
        //   //
        //   if(state is UserProfileLoadFail){
        //     userProfileData=[];
        //     // setData(companyData!);
        //   }
        //
        //   return (companyData!=null)
        //     ?
        //       FutureBuilder<UserProfileModel>(
        //           future: profileData,
        //           builder: (context, snapshot){
        //             if(snapshot.hasData){
        //
        //             }
        //             else if (snapshot.hasError){
        //               return Text("${snapshot.error}");
        //             }
        //             return Container(
        //           // decoration: const BoxDecoration(
        //           //   image: DecorationImage(
        //           //     image: AssetImage(Images.bg),
        //           //     fit: BoxFit.cover,
        //           //   ),
        //           // ),
        //           child:(snapshot.hasData)
        //               ?
        //               :
        //               Center(
        //                 child: CircularProgressIndicator(),
        //               )
        //         );
        //       })
        //
        //       :
        //       Center(child: CircularProgressIndicator());
        // }
        // )
        ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [

            SizedBox(
              height: 0,
            ),

            SizedBox(
                height: 200,
                width: 300,
                child: Center(
                  child: Image.asset('assets/images/Logo.png'),
                  // Text(
                  //   "Unstoppable",
                  //   style: TextStyle(fontSize: FontSize.xxLarge),
                  // ),
                )),

            // CircleAvatar(
            //   radius: 70,
            //   backgroundColor: Colors.orange,
            //   child: Text(
            //     "A",
            //     style: TextStyle(fontSize: 40),
            //   ),
            // ),

            SizedBox(
              height: 0,
            ),
            _MyProfile(context),
            _MyOrders(context),
            _ChangePassword(context),
            _ContactUs(context),
            _RFR(context),
            _GDTDetails(context),

            _LogOutButton(context)
          ],
        )

      ),
    );
  }
}


Widget _MyProfile(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavigation(index: 3,)));
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person,
              color: ThemeColors.drawerTextColor,
            ),
            title: const Text(
              'My Profile',
              style:
              TextStyle(color: ThemeColors.drawerTextColor, fontSize: 16,fontWeight: FontWeight.w400,
              fontFamily: 'SF-Pro-Display'),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _MyOrders(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavigation(index: 1,)));
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: ThemeColors.drawerTextColor,
            ),
            title: const Text(
              'My Orders',
              style:
              TextStyle(color: ThemeColors.drawerTextColor, fontSize: 16,fontWeight: FontWeight.w400,
                  fontFamily: 'SF-Pro-Display'),
            ),
          )
        ],
      ),
    ),
  );
}


Widget _ChangePassword(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChangePassword()));
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.settings,
              color: ThemeColors.drawerTextColor,
            ),
            title: const Text(
              'Change Password',
              style:
              TextStyle(color: ThemeColors.drawerTextColor, fontSize: 16,fontWeight: FontWeight.w400,
                  fontFamily: 'SF-Pro-Display'),
            ),
          )
        ],
      ),
    ),
  );
}


Widget _ContactUs(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactUs()));
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person_rounded,
              color: ThemeColors.drawerTextColor,
            ),
            title: const Text(
              'Contact Us',
              style:
              TextStyle(color: ThemeColors.drawerTextColor, fontSize: 16,fontWeight: FontWeight.w400,
                  fontFamily: 'SF-Pro-Display'),
            ),
          )
        ],
      ),
    ),
  );
}
Widget _RFR(BuildContext context) {
  return InkWell(
    onTap: () {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ContactUs()));
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: ThemeColors.drawerTextColor,
            ),
            title: const Text(
              'Rfr',
              style:
              TextStyle(color: ThemeColors.drawerTextColor, fontSize: 16,fontWeight: FontWeight.w400,
                  fontFamily: 'SF-Pro-Display'),
            ),
          )
        ],
      ),
    ),
  );
}
Widget _GDTDetails(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactUs()));
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person_rounded,
              color: ThemeColors.drawerTextColor,
            ),
            title: const Text(
              'Add your GST details',
              style:
              TextStyle(color: ThemeColors.drawerTextColor, fontSize: 16,fontWeight: FontWeight.w400,
                  fontFamily: 'SF-Pro-Display'),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _LogOutButton(BuildContext context) {
  // LoginBloc? _loginBloc;
  return  Container(color: Colors.white,
          child:Padding(
              padding: EdgeInsets.all(20.0),
              child:

            ElevatedButton(
              onPressed: () {  },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffE31F1F))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout,color: ThemeColors.whiteTextColor,),
                  SizedBox(width: 10,),
                  Text("Logout",style:
                  TextStyle(color: ThemeColors.whiteTextColor, fontSize: 16,fontWeight: FontWeight.w400,
                      fontFamily: 'SF-Pro-Display'),)

                ],
              ),
            )
          )
      );
    // )

  //   InkWell(
  //
  //   onTap: () {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => SignInPage()));
  //   },
  //   child: AppButton(
  //     text: "Log Out",
  //   ),
  // );
}

