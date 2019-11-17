import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicer/modal/menu_modal.dart';
import 'package:servicer/staticbuilder/content_home.dart';
import 'package:servicer/staticbuilder/menu_builder.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  static String _url = "https://puranabazzar.com/api/menu_list.php";

  int size;

  Future<List<MenuModal>> _getMenus() async {
    List<MenuModal> list = [];
    try {
      var response = await http.get(_url);
      var jsonData = json.decode(response.body);
      var res = jsonData["menu"] as List;
      for (int i = 0; i < res.length; i++) {
        MenuModal m = MenuModal(
            id: res[i]['id'],
            image: res[i]['image'],
            title: res[i]['title'],
            parent: res[i]['parent']);
        if (res[i]['parent'] == "0") {
          list.add(m);
        }
      }
      print(list.length);
    } catch (e) {
      return null;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Text(
                        "All Categories",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Text(
                        "View All >",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Color(0xff7F88E4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 140.0,
                child: _menus(),
              ),
              Text(
                "All Categories",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ContentHome()
            ],
          ),
        ),
      ),
    );
  }

  Widget _menus() {
    return FutureBuilder(
      future: _getMenus(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snap.data.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              MenuModal modal = snap.data[index];
              return MenuBuilder(
                id: modal.id,
                image: modal.image,
                title: modal.title,
                parent: modal.parent,
              );
            },
          );
        }
      },
    );
  }
}
