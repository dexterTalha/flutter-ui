import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicer/modal/product_modal.dart';

class ContentHome extends StatelessWidget {
  final String url;
  ContentHome({@required this.url});
  List<bool> fav = [];

  /* products": [
    {
      "id": "16",
      "title": "hdhd",
      "image": "product_images/b059fe48aaf99e2904230caa8e3f48cb0.jpg",
      "price": "50000",
      "condition": "0",
      "desp": "shdhbd",
      "user_id": "9",
      "type": "",
      "address": "lko, lko, 226001"
    },
  */

  Future<List<Product>> _getProducts() async {
    List<Product> list = [];
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      var res = data["products"] as List;
      //print(res);
      int len = (res.length <= 10)?res.length:10;
      for (var i = 0; i < res.length; i++) {
        Product p = Product(
          id: res[i]['id'],
          title: res[i]['title'],
          image: res[i]['image'],
          price: res[i]['price'],
        );
        list.add(p);
      }

      print(list.length);
      return list;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProducts(),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.none || !snap.hasData) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snap.hasData) {
          return ListView.builder(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              Product p = snap.data[index];
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 210,
                  width: 150,
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        elevation: 13.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(10),
                          ),
                          height: 130.0,
                          width: 150.0,
                          child: Center(
                            child: CachedNetworkImage(
                              fit: BoxFit.fitHeight,
                              useOldImageOnUrlChange: true,
                              imageUrl: "https://puranabazzar.com/dashboard/" +
                                  p.image,
                              fadeInCurve: Curves.easeInExpo,
                              height: 120,
                              width: 140,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitHeight,
                                    ),
                                ),
                              ),
                              fadeInDuration: Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                  size: 30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 110,
                            child: Text(
                              p.title.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                wordSpacing: 1.5,
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite_border,
                                size: 25,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
