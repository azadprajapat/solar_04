import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solar04/components/charts/linechart_Year.dart';
import 'package:solar04/components/charts/linechart_month.dart';
import 'package:solar04/components/charts/linechartdaily.dart';
import 'package:solar04/utils/AppTheme.dart';

class GraphSection extends StatefulWidget {
  @override
  _GraphSectionState createState() => _GraphSectionState();
}

class _GraphSectionState extends State<GraphSection> with SingleTickerProviderStateMixin{
  TabController _controller;
  @override
  void initState() {
    _controller=TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.theme1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(-10),
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Hall 13",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800),),
               ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: AppTheme.theme1,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
               SizedBox(height: 40,),
               Container(
                child: TabBar(
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _controller,
                  onTap: (int x) {
                    _controller.index = x;
                    },
                  labelPadding: EdgeInsets.only(bottom: 10.5, left: 0, right: 0),
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                  ),
                  tabs: <Widget>[
                    Text("Year"),
                    Text("Month"),
                    Text("Week")
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChartYear(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChartMonth(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChartDaily(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
