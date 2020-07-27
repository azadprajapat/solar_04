
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:solar04/screens/bottomnavigation/Resultpage.dart';
import 'package:solar04/screens/bottomnavigation/graph.dart';
import 'package:solar04/screens/bottomnavigation/settings.dart';
import 'package:solar04/utils/AppTheme.dart';

class Bottom_Navigation_bar extends StatefulWidget {
    @override
  _Bottom_Navigation_barState createState() => _Bottom_Navigation_barState();
}

class _Bottom_Navigation_barState extends State<Bottom_Navigation_bar> with SingleTickerProviderStateMixin {
    List<Widget> _list;
    int currentindex=0;
    TabController _controller;
    @override
  void initState() {
      _controller=TabController(length: 4, vsync: this);
     setState(() {
     _list=[
      ResultPage(),
       GraphSection(),
       Container(),
       Settings(),
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
        bottomNavigationBar: Container(
          child: SizedBox(
            height: 69,
            child: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: AppTheme.theme2,) ,
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    title: Text("Home"),
                    icon: Icon(FontAwesomeIcons.home),
                  ),
                   BottomNavigationBarItem(
                    title: Text("Graph"),
                    icon: Icon(Icons.poll),
                  ),
                  BottomNavigationBarItem(
                    title: Text("History"),
                    icon: ImageIcon(AssetImage("assets/Path 327.png"),),
                  ),
                  BottomNavigationBarItem(
                    title: Text("More"),
                    icon: Icon(Icons.search),
                  ),
                ],
                iconSize: 26,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.5),
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
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
