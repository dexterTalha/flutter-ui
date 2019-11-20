import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/ui/fragments/chat_fragment.dart';
import 'package:servicer/ui/fragments/favourite_fragment.dart';
import 'package:servicer/ui/fragments/home_fragment.dart';
import 'package:servicer/ui/fragments/my_ad_fragment.dart';
import 'package:servicer/ui/fragments/profile_fragment.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var _selectedIndex = 0;
  void _incrementTab(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    HomeFragment(),
    MyAdFragment(),
    ChatFragment(),
    FavouriteFragment(),
    ProfileFragment()
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff7F88E4),
    ));
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, '/signup');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: RotatedBox(
          quarterTurns: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff7F88E4),
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.only(left: 55),
            height: 50,
            width: 120,
            child: FloatingActionButton(
              elevation: 8,
              backgroundColor: Color(0xff7F88E4),
              splashColor: Color(0xffD0D4F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[Icon(Icons.add_a_photo), Text("Sell")],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 56.0,
                  width: _width,
                  color: Color(0xff7F88E4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Servicer",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications),
                            color: Colors.white,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                screens[_selectedIndex],
                BottomNavigationBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  unselectedIconTheme: IconThemeData(size: 22.0),
                  selectedIconTheme: IconThemeData(size: 23.0),
                  unselectedFontSize: 12.0,
                  unselectedItemColor: Colors.black38,
                  selectedItemColor: Color(0xff7F88E4),
                  selectedFontSize: 13.0,
                  showUnselectedLabels: true,
                  currentIndex: _selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    _incrementTab(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Shop"),
                        ),
                        icon: Icon(
                          Icons.store,
                        )),
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("My Ads"),
                        ),
                        icon: Icon(Icons.shopping_cart)),
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Chats"),
                        ),
                        icon: Icon(Icons.message)),
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Favourites"),
                        ),
                        icon: Icon(Icons.favorite)),
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Profile"),
                        ),
                        icon: Icon(Icons.person))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
