import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/controller/get_banks_controller.dart';
import 'package:beyond_wallet/models/send_money_to_non_wallet_model.dart';
import 'package:beyond_wallet/models/sign_up_model.dart';
import 'package:beyond_wallet/models/verify_otp_model.dart';
import 'package:beyond_wallet/screens/authentication/login.dart';
import 'package:beyond_wallet/screens/home/home_screen.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'localization/constants.dart';
import 'localization/localization.dart';
import 'models/login_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  bool isFrench;
  void setLocale(Locale locale){
    setState(() {
      _locale =locale;
    });
  }
  isLangArabic()async{
    isFrench =await getLocale('isFrench') ?? false;
    if(isFrench){
      setState(() {
        _locale = Locale('fr', 'FR');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SignUpRequestModel()),
        ChangeNotifierProvider(create: (context)=>LocalData()),
        ChangeNotifierProvider(create: (context)=>BalanceController()),
        ChangeNotifierProvider(create: (context)=>SendMoneyToNonWalletRequestModel()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        localeResolutionCallback: (deviceLocale, supportedLocales){
          for(var locale in supportedLocales ){
            if(locale.languageCode==deviceLocale.languageCode && locale.countryCode == deviceLocale.countryCode){
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        locale:_locale,
        supportedLocales: [
          Locale('en','US'),
          Locale('fr','FR'),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Login(),
      ),
    );
  }
}