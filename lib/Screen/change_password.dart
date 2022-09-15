import 'package:flutter/material.dart';
import '../Widget/app_button.dart';
import '../config/image.dart';
import '../constant/theme_colors.dart';




class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _textCurrentPasswordController = TextEditingController();
  final _textNewPasswordController = TextEditingController();
  final _textConfirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isconnectedToInternet = false;
  var mainHeight, mainWidth;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return
        // GetBuilder<ProfileController>(
        // init: ProfileController(),
        // builder: (profile) =>
        Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios, color: ThemeColors.whiteTextColor,),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Change Password',
        style: TextStyle(
          color: ThemeColors.whiteTextColor
        ),),
      ),
      body: SingleChildScrollView(
          child: Container(
        // decoration:  BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(Images.backgroung),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Password', style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SF-Pro-Display-Regular'
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _textCurrentPasswordController,
                        obscureText: false,
                        //initialValue: widget.userdata['name'],
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18,
                          height: 0.8,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: ThemeColors.textFieldHintColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: ThemeColors.textFieldHintColor),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: ThemeColors.textFieldHintColor)),
                          hintText: "",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter current password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            if (_formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('New Password', style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SF-Pro-Display-Regular'
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _textNewPasswordController,
                        obscureText: true,
                        //initialValue: widget.userdata['name'],
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18,
                          height: 0.8,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: ThemeColors.textFieldHintColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: ThemeColors.textFieldHintColor),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: ThemeColors.textFieldHintColor)),
                          hintText: "",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter new password';
                          } else if (_textCurrentPasswordController.text ==
                              value.toString()) {
                            return 'Current password should not be same as new password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            if (_formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Confirm password', style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SF-Pro-Display-Regular'
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _textConfirmPasswordController,
                        obscureText: true,
                        //initialValue: widget.userdata['name'],
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18,
                          height: 0.8,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: ThemeColors.textFieldHintColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: ThemeColors.textFieldHintColor),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: ThemeColors.textFieldHintColor)),
                          hintText: "",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter confirm password';
                          } else if (_textNewPasswordController.text != value) {
                            return 'Confirm password did not match with new password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            if (_formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child:
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Center(
                  child: AppButton(
                    onPressed: () async {},
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    text: 'Update',
                    // loading: login is LoginLoading,
                    disableTouchWhenLoading: true,
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
