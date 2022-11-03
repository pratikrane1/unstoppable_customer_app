

import 'package:flutter/material.dart';
import 'package:unstoppable_customer_app/Screen/Cart/checkout_page.dart';

import '../../Constant/theme_colors.dart';
import '../../Widget/app_button.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _flatNoController = TextEditingController();
  final _areaController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _townController = TextEditingController();

  String _value = "3";



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.clear();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          "Address",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'SF-Pro-Display-Regular',
              color: ThemeColors.whiteTextColor
          ),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Country",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child:
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color:Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color:Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color:Colors.black)),
                        hintText: "Register As",
                      ),
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          value: "3",
                          child:
                          Text(
                            "India",
                            // style: TextStyle(
                            //     fontSize: 18.0, fontWeight: FontWeight.w600),

                          ),
                        ),
                      ],

                      onChanged: (String? value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 10,
                  ),


                  //Name

                  Text("Full Name",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _firstNameController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Name",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //Mobile Number

                  Text("Mobile Number",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _mobileNumberController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.phone,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Mobile Number",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Mobile Number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //Pincode

                  Text("Pincode",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _pinCodeController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Pincode",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Pincode';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //Flat, House Number

                  Text("Flat, House no, Building, Company, Apartment",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _flatNoController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Flat, House no, Building, Company, Apartment",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Flat, House no, Building, Company, Apartment';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  //Area, Street

                  Text("Area, Street",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _areaController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Area, Street",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Area, Street';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),



                  SizedBox(
                    height: 10,
                  ),

                  //Landmark

                  Text("Landmark",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _landmarkController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Landmark",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Landmark';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //State Dropdown

                  Text("State",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child:
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color:Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color:Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color:Colors.black)),
                        hintText: "Register As",
                      ),
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          value: "3",
                          child:
                          Text(
                            "Manufacturers",
                            // style: TextStyle(
                            //     fontSize: 18.0, fontWeight: FontWeight.w600),

                          ),
                        ),
                        DropdownMenuItem(
                          value: "4",
                          child:
                          Text(
                            "Wholesaler",
                            // style: TextStyle(
                            //     fontSize: 18.0, fontWeight: FontWeight.w600),

                          ),
                        ),
                        DropdownMenuItem(
                          value: "5",
                          child:
                          Text(
                            "Retainer",
                            // style: TextStyle(
                            //     fontSize: 18.0, fontWeight: FontWeight.w600),

                          ),
                        ),
                        DropdownMenuItem(
                          value: "6",
                          child:
                          Text(
                            "Service Provide ",
                            // style: TextStyle(
                            //     fontSize: 18.0, fontWeight: FontWeight.w600),

                          ),
                        ),
                        DropdownMenuItem(
                          value: "7",
                          child:
                          Text(
                            "Freelancer",
                            // style: TextStyle(
                            //     fontSize: 18.0, fontWeight: FontWeight.w600),

                          ),
                        ),
                      ],

                      onChanged: (String? value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  //Town , City

                  Text("Town, City",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _townController,
                      obscureText: false,
                      //initialValue: widget.userdata['name'],
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 0.8, color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 0.8, color: Colors.black)),
                        hintText: "Town, City",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter Town, City';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),


                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        AppButton(
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage()));
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          text: 'Use this address',
                          // loading: login is LoginLoading,
                          disableTouchWhenLoading: true,
                        )
                    ),
                  )



                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}