import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import '../../Api/api.dart';
import '../../Model/customer_login.dart';
import '../../Model/customer_login.dart';
import '../../Model/customer_login.dart';
import '../../Repository/UserRepository.dart';
import '../../Utils/application.dart';
import 'changePassword_event.dart';
import 'changePassword_state.dart';

//for multipart
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({this.settingsRepo}) : super(InitialSettingsState());
  final UserRepository? settingsRepo;


  @override
  Stream<SettingsState> mapEventToState(event) async* {
    if (event is OnChangePassword) {
      ///Notify loading to UI
      yield ChangePassLoading();

      Map<String,dynamic> params={
        'user_id':Application.customerLogin!.userId.toString(),
        'old_password':event.currentPwd,
        'new_password':event.newPwd
      };

      var response=await http.post(Uri.parse(Api.CHANGE_PASS),body: params);
      try {
        var resp = json.decode(response.body);
        if(resp['status']=='Success'){
          yield ChangePassSuccess(message: resp['msg']);
        }else{
          yield ChangePassFail(message: resp['msg']);
        }
      }catch(e){
        print(e);
      }


    }




  }
}



