import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unstoppable_customer_app/Bloc/contactUs/contactUs_bloc.dart';
import 'package:unstoppable_customer_app/Bloc/contactUs/contactUs_event.dart';
import 'package:unstoppable_customer_app/Bloc/contactUs/contactUs_state.dart';

import '../Constant/theme_colors.dart';
import '../Widget/app_button.dart';
import '../image_file.dart';

class ContactUsPage extends StatefulWidget {
  ContactUsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool loading = true;

  ContactUsBloc? _contactUsBloc;



  @override
  void initState() {
    super.initState();
    loading;
    _contactUsBloc = BlocProvider.of<ContactUsBloc>(context);
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
                      key: _formKey,
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

                                BlocBuilder<ContactUsBloc, ContactUsState>(
                                    builder: (context, contactUs) {
                                      return BlocListener<ContactUsBloc, ContactUsState>(
                                          listener: (context, state) {
                                            if (state is ContactUsSuccess) {
                                              // Navigator.of(context).pop();
                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DrawerWidget()));
                                              Fluttertoast.showToast(
                                                  msg: state.message.toString());
                                              loading = true;
                                            }
                                            if (state is ContactUsLoading) {
                                              loading = false;
                                            }

                                            if (state is ContactUsfail) {
                                              Fluttertoast.showToast(
                                                  msg: state.message.toString());
                                              loading = false;
                                            }
                                          },
                                          child: Center(
                                            child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: AppButton(
                                                  onPressed: () async {
                                                    if (_formKey.currentState!.validate()) {
                                                      if (_nameController == null) {
                                                        Fluttertoast.showToast(
                                                            msg: "Please enter name");
                                                      } else if (_mobileController == null) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            "Please enter mobile number");
                                                      } else if (_emailController == null) {
                                                        Fluttertoast.showToast(
                                                            msg: "Please enter email");
                                                      } else if (_messageController == null) {
                                                        Fluttertoast.showToast(
                                                            msg: "Please enter message");
                                                      } else if (_formKey.currentState!
                                                          .validate()) {
                                                        _contactUsBloc!.add(ContactUs(
                                                          name: _nameController.text,
                                                          mobileNo: _mobileController.text,
                                                            email: _emailController.text,
                                                           msg: _messageController.text
                                                        ));
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg: "Please fill the data");
                                                    }
                                                  },
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  text: 'Update',
                                                  loading: loading,
                                                )),
                                          ));
                                    })

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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(0),
      //     child:
      //     SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       height: 40,
      //       child: Center(
      //         child: AppButton(
      //           onPressed: () async {},
      //           shape: const RoundedRectangleBorder(
      //               borderRadius:
      //               BorderRadius.all(Radius.circular(10))),
      //           text: 'Submit',
      //           // loading: login is LoginLoading,
      //           disableTouchWhenLoading: true,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
