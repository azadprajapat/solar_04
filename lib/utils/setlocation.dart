import 'package:geolocator/geolocator.dart';
import 'package:solar04/modals/Input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
void setlocation(context)async {
  final inputprovider = Provider.of<Input>(context,listen: false);
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  await geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
       inputprovider.setLongitude(position.longitude.toInt().toString());
      inputprovider.setLattitude(position.latitude.toInt().toString());
    // Navigator.of(context).pop();
  }).catchError((e) {
    print(e);
  });
}