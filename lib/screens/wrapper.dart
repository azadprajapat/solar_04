import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar04/screens/Resultpage.dart';
import 'gettingstarted.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isfirstlaunch;

  Future<void> _getpref() async {
    final SharedPreferences prefs = await _prefs;
    final bool isfirstlaunch =
        await prefs.getBool('isfirstlaunch') != null ? false : true;
    setState(() {
      _isfirstlaunch = isfirstlaunch;
    });
    await prefs.setBool("isfirstlaunch", false);
  }

  @override
  void initState() {
    initialsetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isfirstlaunch != null) {
      return _isfirstlaunch ? Get_Started() : ResultPage();
    } else {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
  void initialsetup() async{
    _getpref();
    setpermission();
  }

  void setpermission() async {
    final Permission _location = Permission.location;
    final Permission _record=Permission.microphone;
    var recordpermisson=await _record.isGranted;
    var locationpermisson = await _location.isGranted;
    final Permission _camera = Permission.camera;
    var _camerapermisson = await _camera.isGranted;
    if (!_camerapermisson) {
      await _camera.request();
    }
    if(!recordpermisson){
      await _record.request();
    }
    if (!locationpermisson) {
      await _location.request();
    }

  }
}
