import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/animation/delay_animation.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final int _delayed = 500;
  double scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Color(0xff7F88E4),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
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
                    height: 120,
                    width: 120,
                  )),
                  shape: CircleBorder(),
                ),
              ),
            ),
            DelayedAnimation(
                child: Text(
                  "Hi there,",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35.0),
                ),
                delay: _delayed + 300),
            DelayedAnimation(
              child: Text(
                "I'm Servicer",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35.0),
              ),
              delay: _delayed + 500,
            ),
            SizedBox(
              height: 50.0,
            ),
            DelayedAnimation(
              child: Text(
                "Your new personal &\ndaily service provider",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black45,
                    fontSize: 20.0),
              ),
              delay: _delayed + 700,
            ),
            SizedBox(
              height: 100.0,
            ),
            DelayedAnimation(
              child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Transform.scale(scale: scale, child: _animatedButton)),
              delay: _delayed + 1100,
            ),
            SizedBox(
              height: 35.0,
            ),
            DelayedAnimation(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "I ALREADY HAVE AN ACCOUNT".toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 17.0),
                ),
              ),
              delay: _delayed + 1300,
            ),
          ],
        ),
      ),
    );
  }
  Widget get _animatedButton => Material(
        child: Container(
          height: 60.0,
          width: 280.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: Center(
            child: Text("Hi, Register here.",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    color: Color(0xff7F88E4))),
          ),
        ),
        elevation: 12.0,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
