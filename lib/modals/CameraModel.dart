
import 'package:flutter/cupertino.dart';

class CameraModel with ChangeNotifier {
  var camera;
  var focal_length;
  var Horizontal_View_angle;
  var Vertical_View_angle;
  void SetCamera(val){
    if(val!=null){
      camera=val;
      notifyListeners();
    }
    else{
      throw Error();
    }
  }
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