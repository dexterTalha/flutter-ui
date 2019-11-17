import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicer/modal/product_modal.dart';

class ContentHome extends StatelessWidget {
  

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
      var response =
          await http.get("https://puranabazzar.com/api/product_list.php");
      var data = json.decode(response.body);
      var res = data["product"] as List;
      for (var item in res) {
        Product p = Product(
            id: item['id'],
            title: item['title'],
            image: item['thumb'],
            price: item['price']);
        list.add(p);
      }
    } catch (e) {
      return null;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProducts(),
      builder: (context, snap) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snap.data.length,
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            Product p = snap.data['index'];
            return Container(
              height: 180.0,
              width: 180.0,
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 12.0,
                    child: Stack(
                      children: <Widget>[
                        Image.network(p.image),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  ),
                  Text(p.title)
                ],
              ),
            );
          },
        );
      }
    );
  }
}