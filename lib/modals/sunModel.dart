import 'package:flutter/cupertino.dart';

class Sun with ChangeNotifier{
  double SunAzimuth;
  double SunPitch;
  void setSunAzimuth(val){
    SunAzimuth=val;
    notifyListeners();
  }
  void setSunPitch(val){
    SunPitch=val;
    notifyListeners();
  }
}