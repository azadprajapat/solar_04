import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:solar04/utils/AppTheme.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
 String loading_text="loading...";
 @override
  void initState() {
    Timer(Duration(seconds: 5), (){
      setState(() {
        loading_text="please wait...";
      });
    });
    Timer(Duration(seconds: 10), (){
      setState(() {
        loading_text="almost there...";
      });
    });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.theme1,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinKitChasingDots(color: Colors.white,size: 60,),
            SizedBox(height: 50,),
            Text(
              loading_text
              ,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),)
          ],
        ),
      ),
    );
  }
}
