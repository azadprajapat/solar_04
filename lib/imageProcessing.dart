import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Immage;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:solar04/modals/Input.dart';
import 'package:solar04/modals/Resultprovider.dart';
import 'package:solar04/utils/sunposition.dart';



class ProcessImage {
  final imagepaths;
  final camera_modal;
  final size;

  ProcessImage({this.imagepaths, this.camera_modal, this.size});

  Process(context) async {
    int row = 910;
    int col = 3610;
    var matrix = List<List<int>>.generate(
        col, (i) => List<int>.generate(row, (j) => 2));
    for (int t = 0; t < 15; t++) {
      var file = await File(imagepaths[t].Imagepath).readAsBytesSync();
      Immage.Image img = await Immage.decodeImage(file);
      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          var pixel = await img.getPixel(i, j);
          var x = i - (img.width) / 2;
          var y = j - ((img.height) / 2);
          assert(imagepaths[t].azimuth is int);
          assert(imagepaths[t].elevation is int);
          var A = await (imagepaths[t].azimuth +
              atan(x / (camera_modal.focal_length)) * 180 / pi);
          var E = await (imagepaths[t].elevation -
              atan(y / (camera_modal.focal_length)) * 180 / pi);
          if (E > 90) {
            E = 90.0;
          }
          if (E < 0) {
            E = 0.0;
          }
          if (A < 90) {
            A = 90.0;
          }
          if (A > 270) {
            A = 270.0;
          }


          A = (A * 10).toInt();
          E = (E * 10).toInt();


          //theresholding over the image matrix
          //matrix[A][E]==0 if current angle(A,E) lie in skyzone and 1 if lies in nonsky zone
          if (Color(pixel).blue > 150) {
            matrix[A][E] = 0;
          } else if (Color(pixel).blue >= Color(pixel).red &&
              Color(pixel).blue >= Color(pixel).green &&
              Color(pixel).blue >= 115) {
            matrix[A][E] = 0;
          }
          else if (Color(pixel).blue >= Color(pixel).red &&
              Color(pixel).blue >= Color(pixel).green &&
              Color(pixel).blue >= 75 && i * j < (img.width * img.height) / 2
          ) {
            matrix[A][E] = 0;
          }
          else {
            matrix[A][E] = 1;
          }
        }
      }
      //callback are  for loading screen
    }

      final inputprovider = Provider.of<Input>(context, listen: false);
      var lat = inputprovider.lattitude;
      var long = inputprovider.longitude;
      //lat and long are the parameters of current location


      int visiblehr = 0;
      //variable to count the number of hour the sun will lie in skyzone

      DateTime time = DateTime(2020, 1, 1, 1);


      for (int i = 0; i < 3284; i++) {
        SunAngle sunAngle = await getsunpos(time, lat, long);
        //azimuth and elevation of sun of the variable time
        //currently we are measuring from 8:00 to 5:00
        if (time.hour >= 8 && time.hour <= 17) {
          if (matrix[sunAngle.azimuth][sunAngle.elevation] == 0) {
            visiblehr++;
          }
          else if (matrix[sunAngle.azimuth][sunAngle.elevation] == 1) {

          }
        }
        else {}
        time = time.add(Duration(hours: 1));
      }
      print(visiblehr.toString());
      var percent = ((visiblehr / 3285.0) * 100).toInt();
      var resultprovider=Provider.of<ResultProvider>(context,listen: false);
      resultprovider.setpercent(percent);
      print(percent);
    }
  }
