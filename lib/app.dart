import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unstoppable_customer_app/Config/theme.dart';

import 'Bloc/authentication/authentication_bloc.dart';
import 'Bloc/authentication/authentication_state.dart';
import 'Config/language.dart';
import 'Screen/Login/sign_in.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'Screen/bottom_navbar.dart';
import 'Utils/routes.dart';
import 'Utils/translate.dart';
import 'app_bloc.dart';




class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}



class _AppState extends State<App> {
  final route = Routes();

  var locator;


  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: AppBloc.providers,
        child:
        MaterialApp(
          // navigatorKey: PushNotify.navigatorKey, // imp nvigator key is used as navigation through context didnt worked
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          locale: AppLanguage.defaultLanguage,

          localizationsDelegates: [
            Translate.delegate,
            // EasyLocalization.of(context).delegate,

            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],

          supportedLocales: AppLanguage.supportLanguage,


          onGenerateRoute: route.generateRoute,
          home:
          BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, app) {

              if (app is AuthenticationSuccess) {
                return BottomNavigation(index: 0,);
              }
              if (app is AuthenticationFail) {
               return SignInPage();
              //  return BottomNavigation(index: 0,);
              }
              return SplashScreen();

            },
          ),

      )

      );

    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //     theme: AppTheme.lightTheme,
    //     darkTheme: AppTheme.darkTheme,
    //     locale: AppLanguage.defaultLanguage,
    //
    //     localizationsDelegates: [
    //       Translate.delegate,
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //     ],
    //     supportedLocales: AppLanguage.supportLanguage,
    //
    //     onGenerateRoute: route.generateRoute,
    //     home:
    //     MultiBlocProvider(
    //       providers: AppBloc.providers,
    //       child:
    //     BlocBuilder<AuthBloc, AuthenticationState>(
    //     builder: (context, app) {
    //       if (app is AuthenticationSuccess) {
    //         return MainNavigation();          }
    //       if (app is AuthenticationFail) {
    //         return ChoiceScreen();
    //       }
    //       return SplashScreen();
    //
    //     },
    //   ),
    // )
    // );
  }
}
