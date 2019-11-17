import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:servicer/animation/delay_animation.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _controller;
  var c_mobile = TextEditingController();
  var c_pin = TextEditingController();
  double _visibility = 0.0;
  var _width, _height;

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
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    scale = 1 - _controller.value;

    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, '/signup');
      },
      child: Scaffold(
        backgroundColor: Color(0xff7F88E4),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: <Widget>[
              Container(
                width: _width,
                height: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80.0))),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned(
                        left: 20,
                        top: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: Icon(
                            Icons.close,
                            size: 35,
                            color: Color(0xff7F88E4),
                          ),
                        )),
                    Positioned(
                      left: 20,
                      top: 80,
                      width: _width,
                      child: Center(
                          child: Text("Verification!",
                              style: TextStyle(
                                  color: Color(0xff7F88E4),
                                  fontSize: 35,
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 200.0,
                  child: fields(),
                ),
              ),
              Opacity(
                child : _visibility == 0.0
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.decelerate,
                      )
                    : AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeInSine,
                        child: pinEntry()),
                        opacity: 1.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/uploadimage');
                  },
                  child: Text(
                    "Do it later! Skip",
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

  Widget pinEntry() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: PinCodeTextField(
            isCupertino: true,
            pinBoxWidth: _width * 0.11,
            pinBoxHeight: _width * 0.11,
            autofocus: false,
            controller: c_pin,
            hideCharacter: false,
            highlight: true,
            highlightColor: Colors.white,
            defaultBorderColor: Colors.white70,
            hasTextBorderColor: Colors.white,
            maxLength: 6,
            onTextChanged: (text) {
              setState(() {
                //hasError = false;
              });
            },
            pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.WRAP,
            wrapAlignment: WrapAlignment.start,
            pinBoxDecoration: ((Color color) {
              return BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: color,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(const Radius.circular(5.0)));
            }),
            pinTextStyle: TextStyle(
                fontSize: 25.0, fontFamily: 'Roboto', color: Color(0xff7F88E4)),
            pinTextAnimatedSwitcherTransition:
                ProvidedPinBoxTextAnimation.scalingTransition,
            pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        DelayedAnimation(
          child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                          actions: <Widget>[
                            Container(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Yes"),
                              ),
                            ),
                            Container(
                              child: FlatButton(
                                onPressed: () {},
                                child: Text("No"),
                              ),
                            )
                          ],
                          insetAnimationCurve: Curves.slowMiddle,
                          insetAnimationDuration: Duration(milliseconds: 2000),
                          title: Text("Pin received successfully."),
                          content: Text("Entered pin is: ${c_pin.text}"));
                    });
                //Navigator.pushReplacementNamed(context, '/uploadimage');
              },
              child: Transform.scale(scale: scale, child: _animatedButton)),
          delay: 800,
        ),
      ],
    );
  }

  Widget fields() {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (input) {
              if (input.trim().isEmpty || input.length < 10) {
                return 'Invalid Moible Number';
              }
            },
            controller: c_mobile,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone_iphone),
              prefix: Text("+91"),
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0))),
              hintText: 'Mobile',
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
            maxLength: 10,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //Navigator.pushReplacementNamed(context, '/login');
                },
                child: Container(
                  height: 50.0,
                  width: 130.0,
                  child: Center(
                    child: Text("Resend OTP?",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            color: Colors.white)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _visibility = 1.0;
                    });
                  }
                  //Navigator.pushReplacementNamed(context, '/login');
                },
                child: Material(
                  child: Container(
                    alignment: Alignment(0.5, -0.5),
                    height: 50.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text("Send OTP",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15.0,
                              color: Color(0xff7F88E4))),
                    ),
                  ),
                  elevation: 12.0,
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
              ),
            ],
          ),
        ]));
  }

  Widget get _animatedButton => Material(
        child: Container(
          height: 60.0,
          width: 280.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: Center(
            child: Text("Confirm",
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
