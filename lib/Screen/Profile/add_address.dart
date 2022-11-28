

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unstoppable_customer_app/Screen/Cart/checkout_page.dart';
import 'package:unstoppable_customer_app/Screen/Profile/address_page.dart';

import '../../Bloc/address/address_bloc.dart';
import '../../Bloc/address/address_event.dart';
import '../../Bloc/address/address_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/address_model.dart';
import '../../Utils/application.dart';
import '../../Widget/app_button.dart';

class AddressPage extends StatefulWidget {
  AddressModel? addressData;
  bool editAddress;
  AddressPage({Key? key,this.addressData, required this.editAddress}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinCodeController = TextEditingController();
  final _flatNoController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  AddressBloc? _addressBloc;
  bool loading = true;

  setData(){
    if(widget.addressData!.id != null){
      _flatNoController.text = widget.addressData!.streetAddress.toString();
      _pinCodeController.text = widget.addressData!.pincode.toString();
      _stateController.text = widget.addressData!.state.toString();
      _cityController.text = widget.addressData!.city.toString();
    }else{
      _flatNoController.text = "";
      _pinCodeController.text = "";
      _stateController.text = "";
      _cityController.text = "";
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressBloc = BlocProvider.of<AddressBloc>(context);
    loading;
    if(widget.addressData!=null){
      setData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinCodeController.clear();
    _flatNoController.clear();
    _stateController.clear();
    _cityController.clear();

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
                   //Pincode



                  //Flat, House Number

                  Text("Flat, House no, Building",style: TextStyle(fontSize: 13.0,
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




                  //Town , City

                  Text("City",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _cityController,
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

                  SizedBox(
                    height: 10,
                  ),

                  //State
                  Text("State",style: TextStyle(fontSize: 13.0,
                      fontWeight: FontWeight.w500,fontFamily: 'SF-Pro-Display-Bold'),),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width ,
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'SF-Pro-Display',fontWeight: FontWeight.w400,
                          fontSize: 14.0,color: ThemeColors.textColor),
                      controller: _stateController,
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
                        hintText: "State",
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter State';
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



                  BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
                    return BlocListener<AddressBloc, AddressState>(
                        listener: (context, state) {
                          if (state is AddAddressSuccess) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                            =>Address()));
                            Fluttertoast.showToast(
                                msg: state.message.toString());
                            loading = true;
                          }
                          if (state is AddAddressLoading) {
                            loading = false;
                          }
                          if (state is AddAddressfail) {
                            Fluttertoast.showToast(
                                msg: state.message.toString());
                            loading = false;
                          }
                          if (state is EditAddressSuccess) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                            =>Address()));
                            Fluttertoast.showToast(
                                msg: state.message.toString());
                            loading = true;
                          }
                          if (state is EditAddressLoading) {
                            loading = false;
                          }
                          if (state is EditAddressfail) {
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
                                  if(widget.editAddress == true){
                                    if (_formKey.currentState!.validate()) {
                                      if (_flatNoController == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter Flat,House no, Building");
                                      } else if (_pinCodeController == null) {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Please enter Pincode");
                                      } else if (_cityController == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter city");
                                      }else if (_stateController == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter state");
                                      } else if (_formKey.currentState!
                                          .validate()) {
                                        _addressBloc!.add(EditAddress(
                                          id: widget.addressData!.id.toString(),
                                          user_id: Application.customerLogin!.userId.toString(),
                                          streetAddress: _flatNoController.text,
                                          pinCode: _pinCodeController.text,
                                          city: _cityController.text,
                                          state: _stateController.text,
                                        ));
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please fill the data");
                                    }

                                  }else{
                                    if (_formKey.currentState!.validate()) {
                                      if (_flatNoController == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter Flat,House no, Building");
                                      } else if (_pinCodeController == null) {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Please enter Pincode");
                                      } else if (_cityController == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter city");
                                      }else if (_stateController == null) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter state");
                                      } else if (_formKey.currentState!
                                          .validate()) {
                                        _addressBloc!.add(AddAddress(
                                          user_id: Application.customerLogin!.userId.toString(),
                                          streetAddress: _flatNoController.text,
                                          pinCode: _pinCodeController.text,
                                          city: _cityController.text,
                                          state: _stateController.text,
                                        ));
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please fill the data");
                                    }
                                  }

                                },
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                text: 'Add Address',
                                loading: loading,
                              )),
                        )

                      // Center(
                      //   child: CircularProgressIndicator(),
                      // )


                    );
                  }
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