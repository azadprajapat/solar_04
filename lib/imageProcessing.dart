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
       var fh = size.width/2/tan(( (camera_modal.Horizontal_View_angle*pi)/180));
       var fv = size.height/2/tan(((camera_modal.Vertical_View_angle)*pi/180));
       int row = 361;
      int col = 91;
      Immage.Image imggg=Immage.Image.rgb(361, 91);
      var matrix = List<List<int>>.generate(
          col, (i) => List<int>.generate(row, (j) => 4279374099));
     // print(atan(1280/(fv))*180/pi);
      // print(atan(720/(fh))*180/pi);
       print(atan(720/(camera_modal.focal_length))*180/pi);
       print(atan(1280/(camera_modal.focal_length))*180/pi);
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
            //  print("Angle values");
              var A = await (imagepaths[t].azimuth + atan(x/(camera_modal.focal_length))*180/pi)
                  .toInt();
              var E = await (imagepaths[t].elevation - atan(y/(camera_modal.focal_length))*180/pi).toInt();
              if(E>90){
                E=90;
              }
              if(E<0){
                E=0;
              }
              if(A<0){
                A=0;
              }
              if(A>360){
                A=360;
              }
//              print(x);
//              print(focallength*100);
//              print(atan(x/focallength)*180/pi);
//              print(atan(y/focallength)*180/pi);
      //        print(A);
        //      print(E);
            //  imggg.setPixelRgba(A, E, r, g, b,);
              imggg.setPixel(A, E, pixel);
            }
          }

        }

   var fl=  await File('${(await getTemporaryDirectory()).path}/imgtotal.png');
     await fl.writeAsBytesSync(Immage.writeJpg(imggg));
      print("written successfully");
         final String path=(fl).path;
        ShareExtend.share(path, "file");
     }
}
