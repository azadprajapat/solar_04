import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as Immage;
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';



class ProcessImage {
final imagepaths;
final camera_modal;
final size;

    ProcessImage({this.imagepaths,this.camera_modal,this.size});

     Process() async{
//       var fh = size.width/2/tan(( (camera_modal.Horizontal_View_angle*pi)/180));
//       var fv = size.height/2/tan(((camera_modal.Vertical_View_angle)*pi/180));
       int row = 3600;
      int col = 900;
      var matrix = List<List<int>>.generate(
          col, (i) => List<int>.generate(row, (j) => 4279374099));
      for(int t=0;t<15;t++) {
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
              if(i==0&&j==0){
                print(" LT  A:${A} & E:${E}");
              }
              if(i==img.width/4&&j==img.height/4){
                print("A:${A} & E:${E}");
              }
              if(i==img.width-1&&j==0){
                print("RT A:${A} & E:${E}");
              }
              if(i==img.width-1&&j==img.height-1){
                print("RB A:${A} & E:${E}");
              }
              if(i==0&&j==img.height-1){
                print("LB  A:${A} & E:${E}");
              }
            matrix[i][j]=pixel;
                }
          }

        }
        print("written successfully");
      }
}
