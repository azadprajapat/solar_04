
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Bottom_Navigation_bar extends StatefulWidget {
    @override
  _Bottom_Navigation_barState createState() => _Bottom_Navigation_barState();
}

class _Bottom_Navigation_barState extends State<Bottom_Navigation_bar> {
    List<Widget> _list;
    int currentindex=0;
    @override
  void initState() {
     setState(() {
     _list=[
      Container(),
       Container(),
       Container(),
       Container(),
       ];
    });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        body: _list[currentindex],
        bottomNavigationBar: SizedBox(
          height: 69,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text("Home"),
                icon: Icon(FontAwesomeIcons.home),
              ),
               BottomNavigationBarItem(
                title: Text("Search"),
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                title: Text("Watchlist"),
                icon: Icon(Icons.star),
              ),
              BottomNavigationBarItem(
                title: Text("Profile"),
                icon: Icon(Icons.person_outline),
              ),
            ],
            iconSize: 26,
            showUnselectedLabels: true,
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black87.withOpacity(0.5),
            currentIndex:currentindex,
            onTap: (val) {
               setState(() {
                 currentindex=val;
              });
            },
            selectedLabelStyle:TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w700,
                color: Colors.black87
            ),
            unselectedLabelStyle:  TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 8.0,
              color: Colors.black87.withOpacity(0.5),
            )
          ),
        ),
      ),
    );
  }
}
