import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as Immage;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:solar04/modals/Input.dart';
import 'package:solar04/utils/sunposition.dart';



class ProcessImage {
final imagepaths;
final camera_modal;
final size;

    ProcessImage({this.imagepaths,this.camera_modal,this.size});

     Process(context,callback) async{
//       var fh = size.width/2/tan(( (camera_modal.Horizontal_View_angle*pi)/180));
//       var fv = size.height/2/tan(((camera_modal.Vertical_View_angle)*pi/180));
       int row = 900;
      int col = 3600;
      var matrix = List<List<int>>.generate(
          col, (i) => List<int>.generate(row, (j) => 2));
       print("#matrix");
      print(matrix[0][0]);
      for(int t=0;t<1;t++) {
          var file = await File(imagepaths[t].Imagepath).readAsBytesSync();
          Immage.Image img = await Immage.decodeImage(file);
           for (int i = 0; i < img.width; i++) {
            for (int j = 0; j < img.height; j++) {
              var pixel = await img.getPixel(i, j);
               var x =  i - (img.width) / 2;
              var y =  j- ((img.height) / 2);
              assert(imagepaths[t].azimuth is int);
              assert(imagepaths[t].elevation is int);
               var A = await (imagepaths[t].azimuth + atan(x/(camera_modal.focal_length))*180/pi)
                  .toInt();
              var E = await (imagepaths[t].elevation - atan(y/(camera_modal.focal_length))*180/pi).toInt();
               if(E>90){
                E=90;
              }
              if(E<0){
                E=0;
              }
              if(A<90){
                A=90;
              }
              if(A>270){
                A=270;
              }
              A=A*10;
              E=E*10;
              if(Color(pixel).blue>150){
               matrix[A][E]=0;
               }else if(Color(pixel).blue>=Color(pixel).red&&Color(pixel).blue>=Color(pixel).green&&Color(pixel).blue>=115){
                matrix[A][E]=0;
               }
              else if(Color(pixel).blue>=Color(pixel).red&&Color(pixel).blue>=Color(pixel).green&&Color(pixel).blue>=75
              &&i*j<(img.width*img.height)/2
              ){
                 matrix[A][E]=0;
              }
              else{
                 matrix[A][E]=1;
              }
            }
          }

        }
      callback(40.0);
        print("written successfully");
      final inputprovider=Provider.of<Input>(context,listen: false);
      var lat=inputprovider.lattitude;
      var long=inputprovider.longitude;
      int visiblehr=0;
        DateTime time=DateTime(2020,1,1,1);
        print(time.toString());
        for(int i=0;i<3000;i++){
        SunAngle sunAngle =  getsunpos(time, lat, long);
       if(time.hour>=8&&time.hour<=17) {
         if (matrix[sunAngle.azimuth][sunAngle.elevation] == 0) {
           visiblehr++;
         }
         else if (matrix[sunAngle.azimuth][sunAngle.elevation] == 1) {}
       }
        time.add(Duration(hours: 1));
//        if(time.difference(DateTime(2020,1,1,1))==0){
//          callback(50.0);
//          print("first month");
//        }
//        if(time.difference(DateTime(2020,3,1,1))==0){
//          callback(80.0);
//          print("3 month");
//        }

        }
        print("completed");
       var percent=((visiblehr/3285.0)*100).toInt();
       print(percent);

     }
}
