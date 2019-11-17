import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/animation/delay_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final int _delayed = 500;
  double scale;
  bool _obscureText = true;
  int textCount = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _controller;
  var c_email = new TextEditingController();
  var c_password = new TextEditingController();

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
    _controller.forward();
    _controller.reverse();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    scale = 1 - _controller.value;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff7F88E4),
      body: SingleChildScrollView(
        child: Container(
          width: _width,
          height: _height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                child: DelayedAnimation(
                  child: Text("Welcome back Mate,\nLogin Here!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 35.0,
                        fontWeight: FontWeight.normal,
                      )),
                  delay: 300 + _delayed,
                ),
              ),
              DelayedAnimation(
                delay: _delayed + 200,
                              child: Container(
                  width: _width,
                  child: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                        height: 280,
                        width: _width - 80,
                        margin: EdgeInsets.only(top: 80.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(500.0),
                                bottomRight: Radius.circular(500.0))),
                        child: fields(),
                      ),
                    ),
                    Positioned(
                      left: 290,
                      bottom: 110,
                      child: GestureDetector(
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          onTap: () {
                            if (_formKey.currentState.validate()) {}
                          },
                          child: Transform.scale(
                              scale: scale, child: _animatedButton)),
                    ),
                  ]),
                ),
              ),
              SizedBox(height: 80.0,),
              Center(
                child: DelayedAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: Text(
                      "New User? SignUp".toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 17.0),
                    ),
                  ),
                  delay: _delayed + 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fields() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 10, right: 50.0),
              child: TextFormField(
                controller: c_email,
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Provide an email';
                  }else if(!input.trim().contains("@")){
                    return "Invalid email";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xff7F88E4)),
                  hintText: 'e.g. somenthing@example.com',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 50.0),
              child: TextFormField(
                controller: c_password,
                keyboardType: TextInputType.text,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter password';
                  } else if (input.length < 8) {
                    return 'Password must be greater than 8';
                  }
                },
                onChanged: (input) {
                  setState(() {
                    textCount = input.length;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counter: Text(
                    textCount == 0 ? "" : textCount.toString(),
                    style: TextStyle(
                        color: textCount < 8 ? Colors.red : Colors.blue),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xff7F88E4)),
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: _obscureText,
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
            )
          ],
        ));
  }

  Widget get _animatedButton => Material(
        child: ClipOval(
          child: Container(
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
            child: CircleAvatar(
              radius: 35,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        shape: CircleBorder(),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
