import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void getcameradata(cameramodal) async {
  final Permission _camera = Permission.camera;
  var result = await _camera.isGranted;
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  cameramodal.SetCamera(firstCamera);
  if(!result){
  await _camera.request();
}
  var platform = const MethodChannel("get");
  if (result) {
    try {
      var result1 = await platform.invokeMethod("get");
      cameramodal.set_focus((result1 * 100).toInt());
    } on PlatformException catch (e) {}
    try {
      var result2 = await platform.invokeMethod("horizon");
      cameramodal.set_Horizontal(result2);
      print("h set successfully");
    } on PlatformException catch (e) {
      print('unable to get vertical ${e}');
    }
    try {
      var result3 = await platform.invokeMethod("vert");
      cameramodal.set_Vertical(result3);
      print("v set successfully");
    } on PlatformException catch (e) {}
  } else {
    print("Permisson is not granted");
  }




}