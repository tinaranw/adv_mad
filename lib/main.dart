import 'dart:io';

import 'package:adv_mad/shared/shared.dart';
import 'package:adv_mad/ui/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void enablePlatformOverrideForDesktop(){
  if(!kIsWeb && (Platform.isMacOS || Platform.isAndroid || Platform.isLinux)){
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async{
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Advanced MAD",
      theme: MyTheme.lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        // '/mainmenu': (context) => MainMenu()

        //lebih modular
        Splash.routeName: (context) => Splash(),
        MainMenu.routeName: (context) => MainMenu(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
      },
    );
  }
}
