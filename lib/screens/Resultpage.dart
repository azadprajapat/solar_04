import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solar04/components/bottom_navigationbar.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

    @override
  void initState() {
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: Container(),
       ),
       bottomNavigationBar: Bottom_Navigation_bar(),
     );
  }
}
