import 'package:flutter/material.dart';

class FavouriteFragment extends StatefulWidget {
  @override
  _FavouriteFragmentState createState() => _FavouriteFragmentState();
}

class _FavouriteFragmentState extends State<FavouriteFragment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Text("Favourite"),
        ),
      ),
    );
  }
}
