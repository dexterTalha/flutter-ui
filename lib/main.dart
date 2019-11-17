import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/routes/routes.dart';
import 'package:servicer/ui/splash_screen.dart';


void main() {
  
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff7F88E4),
    systemNavigationBarColor: Color(0xff7F88E4),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
      theme: ThemeData(
        fontFamily: 'Roboto',
        accentColor: Colors.black
      ),
    );
  }
}