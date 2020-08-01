import 'package:flutter/cupertino.dart';

class ResultProvider with ChangeNotifier{
  var percent=40;
  setpercent(val){

   percent=val;
   notifyListeners();
  }

}