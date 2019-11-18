import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/animation/delay_animation.dart';
import 'package:servicer/staticbuilder/top_bar.dart';

class EmailSignUpScreen extends StatefulWidget {
  @override
  _EmailSignUpScreenState createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen>
    with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  bool _obscureTextC = true;
  int textCount = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _controller;
  var c_email = new TextEditingController();
  var c_password = new TextEditingController();
  var c_confirm_password = new TextEditingController();
  var c_name = new TextEditingController();
  double scale;
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    scale = 1 - _controller.value;

    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, '/signup');
      },
      child: Scaffold(
        backgroundColor: Color(0xff7F88E4),
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: <Widget>[
              ScreenTopBar(
                callback: () {},
                title: "Welcome! ",
                height: 160,
                width: _width,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(child: fields()),
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/otpverification');
                      //if (_formKey.currentState.validate()) {}
                    },
                    child:
                        Transform.scale(scale: scale, child: _animatedButton)),
                delay: 800,
              ),
              SizedBox(
                height: 20.0,
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
                delay: 890,
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
              padding: const EdgeInsets.only(left: 30, right: 30.0),
              child: TextFormField(
                controller: c_name,
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Provide a name';
                  }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  counterText: "",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  hintText: 'Name',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 1,
                maxLength: 15,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30.0),
              child: TextFormField(
                controller: c_email,
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Provide an email';
                  } else if (!input.trim().contains("@")) {
                    return "Invalid email";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  hintText: 'Email',
                ),
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30.0),
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
                  prefixIcon: Icon(Icons.vpn_key),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  //     counterStyle: TextStyle(
                  //       color: textCount < 8 ? Colors.red : Colors.white),
                  // counterText: textCount == 0 ? "" : textCount.toString(),
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
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30.0),
              child: TextFormField(
                controller: c_confirm_password,
                keyboardType: TextInputType.text,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter password';
                  } else if (input != c_confirm_password.text) {
                    return 'Confirm password do not match';
                  }
                },
                onChanged: (input) {
                  setState(() {
                    textCount = input.length;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  // counter: Text(
                  //   textCount == 0 ? "" : textCount.toString(),
                  //   style: TextStyle(
                  //       color: textCount < 8 ? Colors.red : Colors.white),
                  // ),
                  hintText: 'Confirm Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureTextC = !_obscureTextC;
                      });
                    },
                    child: Icon(_obscureTextC
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                obscureText: _obscureTextC,
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
            )
          ],
        ));
  }

  Widget get _animatedButton => Material(
        child: Container(
          height: 60.0,
          width: 280.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: Center(
            child: Text("Continue",
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
