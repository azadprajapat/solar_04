import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Input with ChangeNotifier{
  var name='';
  var camera;
  var lattitude;
  var longitude;
  double temperature;
  double pressure;
  double humidity;
  var imagepaths=[];
  double Sazimuth;
  DateTime dateTime;
  double Spitch;
  CameraController controller;
  Future<void> initialiseControllerFuture;
void set_initializeControllerFuture(){
  initialiseControllerFuture = controller.initialize();
}
void set_controller(){
  controller = CameraController(camera, ResolutionPreset.medium);
}

  void setName(val){
    name=val;
    notifyListeners();
  }
  void setCamera(val){
    camera=val;
    notifyListeners();
  }
  void setLattitude(val){
    lattitude=val;
    notifyListeners();
  }
  void setLongitude(val){
    longitude=val;
    notifyListeners();
  }
  void setTemperature(val){
    temperature=val;
    notifyListeners();
  }
  void setPressure(val){
    pressure=val;
    notifyListeners();
  }
  void setHumidity(val){
    humidity=val;
    notifyListeners();
  }
  void setPath(val){
    imagepaths.add(val);
      notifyListeners();
  }
  void setAzimuth(val){
    Sazimuth=val;
    notifyListeners();
  }
  void setElevation(val){
   Spitch=val;
    notifyListeners();
  }
  void setDate(val){
      dateTime = val;

     notifyListeners();
  }
  void TakePhoto() async{
    await initialiseControllerFuture;
    final path =
        (await getTemporaryDirectory()).path +
        '${DateTime.now()}.jpg';
       imagepaths.add(path);
       print('# STATUS 200 ${path}');
    await controller.takePicture(path);
  }

}