import 'package:cached_network_image/cached_network_image.dart';
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: <Widget>[
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                      _stories,
                    ],
                  ),
                ),
                //ChatList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _stories => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: 130,
          height: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 130,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://i.pinimg.com/originals/a3/79/ed/a379ed1bfe120e37570cec581fc824f2.jpg",
                        fadeInCurve: Curves.bounceIn,
                        height: 150,
                        width: 130,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 150,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: imageProvider,
                            ),
                          ),
                        ),
                        fadeInDuration: Duration(milliseconds: 300),
                        alignment: Alignment.center,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Center(
                            child: Icon(Icons.error,
                                color: Colors.red[900], size: 30)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.6,
                        child: Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.grey[900],
                                Colors.grey[800],
                                Colors.grey[700],
                                Colors.grey[600],
                                Colors.grey[500],
                                Colors.grey[400],
                                Colors.grey[300],
                                Colors.white10,
                                Colors.white30,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Center(
                          child: Text(
                        "My Stories",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )),
                    ),
                    Positioned(
                      bottom: -30,
                      left: 30,
                      child: Center(
                        child: Material(
                          shape: CircleBorder(
                              side:
                                  BorderSide(width: 3.5, color: Colors.black)),
                          child: CircleAvatar(
                            radius: 30,
                            child: FlutterLogo(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Today\n12:30",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
