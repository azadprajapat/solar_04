import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

 var x;
 var y=0.0;
   @override
  void initState() {
       x=sqrt(10000-y*y);
     Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(y>=100&&x>0){
          y-=5;
          x=-sqrt(10000-y*y);
        }else {
          y+=5;
          x=sqrt(10000-y*y);
         }



      });
       });
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.grey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: x+180,
              top: y+360,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(40)
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
