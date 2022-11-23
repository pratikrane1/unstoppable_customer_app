
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unstoppable_customer_app/Screen/Login/sign_in.dart';
import 'package:unstoppable_customer_app/Screen/Profile/edit_profile.dart';
import 'package:unstoppable_customer_app/Widget/profile_shimmer.dart';
import '../../Api/api.dart';
import '../../Bloc/profile/profile_bloc.dart';
import '../../Bloc/profile/profile_event.dart';
import '../../Bloc/profile/profile_state.dart';
import '../../Config/image.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/user_profile_model.dart';
import '../../Utils/application.dart';
import '../../image_file.dart';
import '../change_password.dart';
import 'address_page.dart';


class MyProfile extends StatefulWidget {
  // UserProfileRepo? profileData;
  MyProfile({
    Key? key,
    // required this.profileData
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ImageFile? imageFile;
  final picker = ImagePicker();
  bool flagLoading = false;
  bool loading = true;

  ProfileBloc? _probileBloc;
  UserProfileRepo? profileData;


  @override
  void initState() {
    super.initState();
    loading;
    if(Application.customerLogin!.userId != null){
      _probileBloc = BlocProvider.of<ProfileBloc>(context);
      _probileBloc!.add(GetProfile(user_id: Application.customerLogin!.userId.toString()));;
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('You need to Sign in First'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInPage()));
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<Null> _onRefresh() {
    setState(() {
      _probileBloc!.add(GetProfile(user_id: Application.customerLogin!.userId.toString()));;
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future;
  }


  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: ThemeColors.whiteTextColor),
        ),
        leading: GestureDetector(
          onTap: () {
          },
          child: Icon(Icons.arrow_back_ios, color: ThemeColors.baseThemeColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if(Application.customerLogin!.userId != null){
                Application.preferences!.remove('user');
              }
              // _RemoverUser();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                    (Route<dynamic> route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Application.customerLogin!.userId != null ?
      RefreshIndicator(
        onRefresh: _onRefresh,

        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,

        child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          return BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileSuccess) {
                  profileData = state.profileData;
                  // setData(companyData!);
                }


                if (state is ProfileLoading) {
                  // profileData = [];
                  // setData(companyData!);
                }

                //
                if (state is Profilefail) {
                  // profileData = [];
                  // setData(companyData!);
                }
              },

              child:  profileData != null ?
              SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),

                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: ThemeColors.whiteTextColor,
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 150.0,
                                  height: 150.0,
                                  child: (profileData!.profile_img == null || profileData!.profile_img == "")
                                      ? Image.asset(
                                    Images.profile_icon,
                                    fit: BoxFit.fill,
                                  ): Image.network(
                                    profileData!.profile_img.toString(),
                                    fit: BoxFit.fill,
                                  )

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //Name
                      (profileData!.name == null || profileData!.name == "") ? Container() :
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            //Name
                            Container(
                              height: 40,
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.userTie,
                                  color:
                                  ThemeColors.baseThemeColor,
                                  size: 26,
                                ),
                                title: Text(
                                  profileData!.name.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),

                            Application.address != null ?
                            Container(
                              height: 40,
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.streetView,
                                  color:
                                  ThemeColors.baseThemeColor,
                                  size: 20,
                                ),
                                title: Text(
                                  Application.address!.streetAddress.toString()+', '+Application.address!.city.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ): Container(),

                            // //Address
                            // (profileData!.address == null || profileData!.address == "") ? Container() :
                            // Container(
                            //   height: 40,
                            //   child: ListTile(
                            //     leading: Icon(
                            //       FontAwesomeIcons.streetView,
                            //       color:
                            //       ThemeColors.baseThemeColor,
                            //       size: 20,
                            //     ),
                            //     title: Text(
                            //       profileData!.address.toString(),
                            //       style: TextStyle(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.w400,
                            //         color: Colors.grey.shade700,
                            //       ),
                            //     ),
                            //   ),
                            // ),


                            //Mobile No
                            (profileData!.mobileNo == null || profileData!.mobileNo == "") ? Container() :
                            Container(
                              height: 40,
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color:
                                  ThemeColors.baseThemeColor,
                                  size: 20,
                                ),
                                title: Text(
                                  profileData!.mobileNo.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),


                            //Edit profile
                            GestureDetector(
                              child: Container(
                                height: 40,
                                child: ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.userEdit,
                                    color: ThemeColors.baseThemeColor,
                                    size: 20,
                                  ),
                                  title: Text('Edit Profile',
                                      style: TextStyle(
                                          color: ThemeColors
                                              .baseThemeColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                  trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color:
                                      ThemeColors.baseThemeColor),
                                ),
                              ),
                              onTap: () {
                               Navigator.push(context,
                               MaterialPageRoute(builder: (context)=> EditProfile(profileData: profileData,)));
                              },
                            ),

                            //Address
                            GestureDetector(
                              child: Container(
                                height: 40,
                                child: ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.solidAddressCard,
                                    color: ThemeColors.baseThemeColor,
                                    size: 20,
                                  ),
                                  title: Text('Address',
                                      style: TextStyle(
                                          color: ThemeColors
                                              .baseThemeColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                  trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color:
                                      ThemeColors.baseThemeColor),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> Address()));
                              },
                            ),


                            //Change Password
                            GestureDetector(
                              child: Container(
                                height: 40,
                                child: ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.key,
                                    color: ThemeColors.baseThemeColor,
                                    size: 20,
                                  ),
                                  title: Text('Change Password',
                                      style: TextStyle(
                                          color: ThemeColors
                                              .baseThemeColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                  trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color:
                                      ThemeColors.baseThemeColor),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditPasswordPage()));
                              },
                            ),
                          ],
                        ),
                      ),


                    ],
                  )

              ) : ProfileShimmer()

              // Center(
              //   child: CircularProgressIndicator(),
              // )


          );
        }
        ),
      )
          : _buildPopupDialog(context)

    );
  }
}
