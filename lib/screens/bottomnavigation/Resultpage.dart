import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar04/components/bottomsheet.dart';
import 'package:solar04/modals/CameraModel.dart';
import 'package:solar04/modals/Resultprovider.dart';
import 'package:solar04/modals/locationModel.dart';
import 'package:solar04/utils/AppTheme.dart';
import 'package:solar04/utils/getcameradata.dart';
import 'package:solar04/utils/setlocation.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../Camerascreen.dart';
import '../fetchlocation.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<LocationModel> _list;
  int currentlocationindex = 0;
  int percent;
  String speedometer_text;
  @override
  void initState() {
    var resultprovider=Provider.of<ResultProvider>(context,listen: false);
    setState(() {
      percent=resultprovider.percent;
      if(percent<20){
        setState(() {
          speedometer_text="very low";
        });
      }
      else if(percent>=20&&percent<40){
        setState(() {
          speedometer_text="low";
        });
      }
      else if(percent>=40&&percent<60){
        setState(() {
          speedometer_text="average";
        });
      }
      else if(percent>=60&&percent<80){
        setState(() {
          speedometer_text="high";
        });
      }
      else {
        setState(() {
          speedometer_text="very high";
        });
      }
      _list = [
        LocationModel(name: "Hall 13", lat: 23, long: 45),
        LocationModel(name: "Hall 12", lat: 23, long: 45),
        LocationModel(name: "Hall 8", lat: 23, long: 45),
        LocationModel(name: "Hall 9", lat: 23, long: 45),
        LocationModel(name: "Hall 10", lat: 23, long: 45),
        LocationModel(name: "Hall 11", lat: 23, long: 45),
        LocationModel(name: "Hall 7", lat: 23, long: 45),
        LocationModel(name: "Hall 6", lat: 23, long: 45),
        LocationModel(name: "Hall 5", lat: 23, long: 45),
        LocationModel(name: "Hall 4", lat: 23, long: 45),
        LocationModel(name: "Hall 3", lat: 23, long: 45),
      ];
    });
    _getpref();
    super.initState();
  }

  void refresh(val) {
    setState(() {
      currentlocationindex = val;
    });
  }

  Future<void> _getpref() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool("isfirstlaunch", false);
  }

  @override
  Widget build(BuildContext context) {
    final camera_model = Provider.of<CameraModel>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.theme1,
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
                Text(
                  _list[currentlocationindex].name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Speedometer(
                minValue: 0,
                maxValue: 100,
                size: 170,
                currentValue: percent,
                meterColor: Colors.redAccent,
                warningValue: 30,
                warningColor: Colors.green,
                kimColor: Colors.blueAccent,
                displayNumericStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
                displayText: speedometer_text,
                displayTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
                backgroundColor: AppTheme.theme1,
              ),
              Spacer(
                flex: 10,
              ),
              Text(
                "01/01/2020 - 31/01/2020 ",
                maxLines: 2,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              Spacer(
                flex: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'your selected location is receiving ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(text: speedometer_text, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)),
                      TextSpan(text:" sunvisibility over the selected duration" ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  textpill("open", "camera", Icons.camera, () async {
                    await getcameradata(camera_model);
                    final locationpermisson = Permission.location;
                    await locationpermisson.request();
                    var status = await locationpermisson.isGranted;
                    if (status) {
                      setlocation(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Camera_screen(cameramodal: camera_model)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Get_Location()));
                    }
                  }),
                  textpill("Change", "duration", FontAwesomeIcons.calendarAlt,
                      () async {
                    final List<DateTime> picked =
                        await DateRagePicker.showDatePicker(
                            context: context,
                            initialFirstDate: new DateTime.now(),
                            initialLastDate:
                                (new DateTime.now()).add(new Duration(days: 4)),
                            firstDate: new DateTime(2020, 1, 1),
                            lastDate: new DateTime(2020, 12, 31));
                    if (picked != null && picked.length == 2) {
                      print(picked);
                    }
                  }),
                ],
              ),
              Spacer(
                flex: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  textpill("Change", "location", Icons.location_on, () {
                    rootBottomSheet(
                        context, currentlocationindex, _list, refresh);
                  }),
                  textpill("Show", "more", Icons.explore, () {}),
                ],
              ),
              Spacer(
                flex: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textpill(t1, t2, icon, onpresss) {
    return InkWell(
      onTap: onpresss,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            color: AppTheme.theme2, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: -20,
              left: 55,
              child: Center(
                child: Icon(icon, size: 40, color: Colors.white),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      t1,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    Text(
                      t2,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}
