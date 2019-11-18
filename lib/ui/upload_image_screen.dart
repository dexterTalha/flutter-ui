import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:servicer/animation/delay_animation.dart';
import 'package:servicer/staticbuilder/top_bar.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;

  Future<File> imageFile;

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
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: <Widget>[
              ScreenTopBar(
          callback: (){

          },
          title: "Profile Picture! ",
          height: 160,
          width: _width,
        ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: _width,
                height: _height / 3,
                child: Center(
                  child: Stack(children: <Widget>[
                    FutureBuilder(
                      future: imageFile,
                      builder: (context, data) {
                        if (data.hasData) {
                          return Material(
                              elevation: 18.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                radius: 100,
                                child: ClipOval(
                                  child: Image.file(
                                    data.data,
                                    height: 300,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ));
                        } else {
                          return Material(
                            elevation: 18.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                radius: 100.0,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/icon.png",
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                              ));
                        }
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          imageFile =
                              ImagePicker.pickImage(source: ImageSource.gallery)
                                  .whenComplete(() {
                            setState(() {});
                          });
                        },
                        child: Material(
                          shape: CircleBorder(),
                          elevation: 6.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: Color(0xff7F88E4),
                              size: 40.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
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
                      Navigator.pushReplacementNamed(context, '/setupcomplete');
                    },
                    child:
                        Transform.scale(scale: scale, child: _animatedButton)),
                delay: 300,
              ),
              SizedBox(
                height: 20.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/setupcomplete');
                  },
                  child: Text(
                    "Do it later! Skip",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: 17.0),
                  ),
                ),
                delay: 400,
              ),
            ],
          ),
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
            child: Text("Upload Image",
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
