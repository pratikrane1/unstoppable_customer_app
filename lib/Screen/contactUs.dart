import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Constant/theme_colors.dart';
import '../Widget/app_button.dart';
import '../image_file.dart';

class ContactUs extends StatefulWidget {
  ContactUs({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();





  @override
  void initState() {
    super.initState();
  }

  void dispose(){
    super.dispose();
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _messageController.clear();
  }


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.baseThemeColor,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {

            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios,color: ThemeColors.whiteTextColor),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact Us",
                  style: TextStyle(color: ThemeColors.whiteTextColor),
                ),

                // myAppBarIcon(),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(alignment: Alignment.topLeft, child: Text("Name",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'
                                  ),)),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  // initialValue: companyData![0].name.toString(),
                                  controller: _nameController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  decoration:  InputDecoration(
                                    hintText: "name",
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                    hintStyle: TextStyle(fontSize: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                        borderSide:
                                        BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),

                                  ),
                                  validator: (value) {
                                    // profile.name = value!.trim();
                                    // Pattern pattern =
                                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    // RegExp regex =
                                    // new RegExp(pattern.toString());
                                    if(value==null || value.isEmpty){
                                      return 'Please enter name';
                                    }
                                    // else if(!regex.hasMatch(value)){
                                    //   return 'Please enter valid name';
                                    // }
                                    return null;
                                  },
                                  onChanged: (value) {

                                    // profile.name = value;
                                    setState(() {
                                      // _nameController.text = value;
                                      if ( _formKey.currentState!.validate()) {}

                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Align(alignment: Alignment.topLeft, child: Text("Mobile Number",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'
                                  ),)),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  // initialValue: companyData![0].name.toString(),
                                  controller: _mobileController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  decoration:  InputDecoration(
                                    hintText: "Mobile Number",
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                    hintStyle: TextStyle(fontSize: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                        borderSide:
                                        BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),

                                  ),
                                  validator: (value) {
                                    // profile.name = value!.trim();
                                    // Pattern pattern =
                                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    // RegExp regex =
                                    // new RegExp(pattern.toString());
                                    if(value==null || value.isEmpty){
                                      return 'Please enter Mobile Number';
                                    }
                                    // else if(!regex.hasMatch(value)){
                                    //   return 'Please enter valid name';
                                    // }
                                    return null;
                                  },
                                  onChanged: (value) {

                                    // profile.name = value;
                                    setState(() {
                                      // _nameController.text = value;
                                      if ( _formKey.currentState!.validate()) {}

                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Align(alignment: Alignment.topLeft, child: Text("Email",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'
                                  ),)),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  // initialValue: companyData![0].name.toString(),
                                  controller: _emailController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  decoration:  InputDecoration(
                                    hintText: "Email",
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                    hintStyle: TextStyle(fontSize: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                        borderSide:
                                        BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),

                                  ),
                                  validator: (value) {
                                    // profile.name = value!.trim();
                                    // Pattern pattern =
                                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    // RegExp regex =
                                    // new RegExp(pattern.toString());
                                    if(value==null || value.isEmpty){
                                      return 'Please enter Email';
                                    }
                                    // else if(!regex.hasMatch(value)){
                                    //   return 'Please enter valid name';
                                    // }
                                    return null;
                                  },
                                  onChanged: (value) {

                                    // profile.name = value;
                                    setState(() {
                                      // _nameController.text = value;
                                      if ( _formKey.currentState!.validate()) {}

                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Align(alignment: Alignment.topLeft, child: Text('Message',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Pro-Display-Regular'
                                  ),)),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _messageController,
                                  // initialValue: companyData![0].businessAddress.toString(),
                                  obscureText: false,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  decoration:  InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                    hintStyle: TextStyle(fontSize: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide:
                                      BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide:
                                        BorderSide(width: 0.8, color: ThemeColors.textFieldBgColor)),
                                    hintText:"Message",
                                  ),
                                  validator: (value) {
                                    if(value==null || value.isEmpty){
                                      return 'Please enter Message';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      if ( _formKey.currentState!.validate()) {}
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
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
                text: 'Submit',
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
