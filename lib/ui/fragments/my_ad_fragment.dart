import 'package:flutter/material.dart';

class MyAdFragment extends StatefulWidget {
  @override
  _MyAdFragmentState createState() => _MyAdFragmentState();
}

class _MyAdFragmentState extends State<MyAdFragment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Text("my ad"),
        ),
      ),
    );
  }
}
