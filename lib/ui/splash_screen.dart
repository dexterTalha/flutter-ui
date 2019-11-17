import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:servicer/animation/delay_animation.dart';
import 'package:servicer/ui/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   startTimeout();
  // }

  void handleTimeout() {

   Navigator.pushReplacement(context, MaterialPageRoute(
     fullscreenDialog: true,
     builder: (BuildContext context) => MainPage()));
   
  }

  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, handleTimeout);
  }

  @override
  Widget build(BuildContext context) {
    
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    startTimeout();
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff7F88E4),
              Color(0xffD0D4F5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'indicator',
              child: AvatarGlow(
                endRadius: 90.0,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Material(
                  elevation: 12.0,
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/icon.png',
                    height: 150,
                    width: 150,
                  )),
                  shape: CircleBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            DelayedAnimation(
                          child: GestureDetector(
                            onTap: (){
                              handleTimeout();
                            },
                                                      child: Text(
                "SERVICER",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
                          ),
              delay: 300,
            )
          ],
        ),
      ),
    );
  }
}
