import 'package:flutter/material.dart';

class ChatFragment extends StatefulWidget {
  @override
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Text("chat"),
        ),
      ),
    );
  }
}
