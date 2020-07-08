
import 'package:flutter/cupertino.dart';

class CameraModel with ChangeNotifier {
  var focal_length;
  var Horizontal_View_angle;
  var Vertical_View_angle;
  void set_focus(val){
    if(val==null){
      print(" # NULL ASSIGNED");
    }
    else{
      print("# NULL WAS NOT ASSIGNED");
    }
     focal_length=val;
    notifyListeners();
  }
  void set_Horizontal(val){
     Horizontal_View_angle=val;
    notifyListeners();
  }
  void set_Vertical(val){
     Vertical_View_angle=val;
    notifyListeners();
  }


}