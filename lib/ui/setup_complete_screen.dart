import 'package:flutter/material.dart';

class SetupCompleteScreen extends StatefulWidget {
  @override
  _SetupCompleteScreenState createState() => _SetupCompleteScreenState();
}

class _SetupCompleteScreenState extends State<SetupCompleteScreen> with SingleTickerProviderStateMixin {
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
    scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Color(0xffDDE0FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(width: 4.0, color: Color(0xff7F88E4))),
                child: Icon(
                  Icons.check,
                  color: Color(0xff7F88E4),
                  size: 60,
                )),
            SizedBox(
              height: 30,
            ),
            Text("Setup Complete!",
                style: TextStyle(
                    fontSize: 35,
                    color: Color(0xff7F88E4),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto')),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Transform.scale(scale: scale, child: _animatedButton)),
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
