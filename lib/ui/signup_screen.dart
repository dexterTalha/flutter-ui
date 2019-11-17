import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/animation/delay_animation.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {


  final int _delayed = 500;
  double scaleE, scaleG, scaleF;
  AnimationController _controllerE;
  @override
  void initState() {
    _controllerE = AnimationController(
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    scaleE = 1 - _controllerE.value;
    scaleG = 1 - _controllerE.value;
    scaleF = 1 - _controllerE.value;
    return Scaffold(
        backgroundColor: Color(0xff7F88E4),
        body: SafeArea(
          child: Center(
              child: Column(children: <Widget>[
            SizedBox(height: 30.0),
            Text(
              "SignUp to Continue",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.white, fontSize: 35.0),
            ),
            SizedBox(height: 150.0),
            DelayedAnimation(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/emailregistration'
                    );
                  },
                  child: Transform.scale(
                      scale: scaleE,
                      child: _animatedButton(
                          'SignUp With Email',
                          'assets/images/email.png',
                          Color(0xff7F88E4),
                          Colors.white))),
              delay: _delayed + 200,
            ),
            SizedBox(height: 30.0),
            DelayedAnimation(
              child: GestureDetector(
                  onTap: () {},
                  child: Transform.scale(
                      scale: scaleG,
                      child: _animatedButton(
                          'SignUp With Google',
                          'assets/images/search.png',
                          Color(0xff7F88E4),
                          Colors.white))),
              delay: _delayed + 200,
            ),
            SizedBox(height: 30.0),
            DelayedAnimation(
              child: GestureDetector(
                  onTap: () {},
                  child: Transform.scale(
                      scale: scaleF,
                      child: _animatedButton(
                          'SignUp With Facebook',
                          'assets/images/facebook.png',
                          Colors.white,
                          Color(0xff3B5999)))),
              delay: _delayed + 200,
            ),
            SizedBox(
              height: 45.0,
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
              delay: _delayed + 800,
            ),
          ])),
        ));
  }

  Widget _animatedButton(
      String title, String image, Color textColor, Color background) {
    return Material(
      child: Container(
        height: 60.0,
        width: 280.0,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  image,
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(title,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        color: textColor)),
              ),
            ),
          ],
        ),
      ),
      elevation: 12.0,
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
    );
  }
}
