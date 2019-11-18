import 'package:flutter/material.dart';

class ScreenTopBar extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final void Function() callback;
  ScreenTopBar(
      {@required this.title, @required this.height, @required this.width, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0))),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              left: 20,
              top: 20,
              child: GestureDetector(
                onTap: callback,
                child: Icon(
                  Icons.close,
                  size: 35,
                  color: Color(0xff7F88E4),
                ),
              )),
          Positioned(
            left: 20,
            top: 60,
            width: width,
            child: Center(
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff7F88E4),
                        fontSize: 35,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
    );
  }
}
