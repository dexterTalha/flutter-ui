import 'package:flutter/material.dart';

class MenuBuilder extends StatelessWidget {

  final title, image, id, parent;

  MenuBuilder({this.id, this.image, this.parent, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: 6.0,
            shape: CircleBorder(),
            child: ClipOval(
              child: Image.network(
                this.image,
                height: 60,
                width: 60,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              width: 60.0,
              child: Center(
                child: Text(
                  this.title,
                  maxLines: 1,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.longestLine,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
