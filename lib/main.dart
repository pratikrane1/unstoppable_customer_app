// @dart=2.9
import 'package:flutter/material.dart';

import 'Screen/Login/sign_in.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp();
  // Application.preferences = await SharedPreferences.getInstance();
  //
  // Bloc.observer = BlocObserver();
  // final route = Routes();


  // runZonedGuarded((){
  //   runApp(
  //     App());
  // },
  //     FirebaseCrashlytics.instance.recordError
  // );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Color(0xffDF5F00),
  // ));
  runApp(App());
}