import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:aeyrium_sensor/aeyrium_sensor.dart';
import 'package:camera/camera.dart' as camera_;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:path/path.dart';
import 'package:solar04/modals/CameraModel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;
import 'CameraPainter.dart';
import 'imageProcessing.dart';


class Camera_screen extends StatefulWidget {

  @override
  _Camera_screen_state createState() => _Camera_screen_state();
}

class _Camera_screen_state extends State<Camera_screen> {
   List<ui.Image> imgframelist=[];
  camera_.CameraController _controller;
  Future<void> _initialiseControllerFuture;
  var pitch;
  var roll;
  List _list1 = [
    {"A": "110", "E": "22"},
    {"A": "145", "E": "22"},
    {"A": "180", "E": "22"},
    {"A": "215", "E": "22"},
    {"A": "250", "E": "22"},
    {"A": "110", "E": "44"},
    {"A": "145", "E": "44"},
    {"A": "180", "E": "44"},
    {"A": "215", "E": "44"},
    {"A": "250", "E": "44"},
    {"A": "110", "E": "66"},
    {"A": "145", "E": "66"},
    {"A": "180", "E": "66"},
    {"A": "215", "E": "66"},
    {"A": "250", "E": "66"},
  ];
  List<Points> _list = List<Points>();
  List<Points> _visible_point_list = List<Points>();
  int list_index;
  int number = 0;
  List<Image_set> _imglist = [];
  var azimuth;
  StreamSubscription<dynamic> _streamSubscriptions;
  StreamSubscription<dynamic> _streamSubscriptions2;

  @override
  void initState() {
    initializeCamera();

    _list1.forEach((element) {
      _list.add(Points(A: element['A'], E: element['E']));
    });
    _visible_point_list.add(_list[0]);
    print("# STATUS 200 VISIBLE LIST");
    super.initState();
    _streamSubscriptions = AeyriumSensor.sensorEvents.listen((event) {
      setState(() {
        pitch = ((event.pitch) * 180 / math.pi).toInt();
        roll = (event.roll).toInt();
      });
    });
    _streamSubscriptions2 = FlutterCompass.events.listen((event) {
      setState(() {
        azimuth = event.toInt();
      });
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      _visible_point_list.forEach((element) {
        var current_A=int.parse(element.A);
        var current_E=int.parse(element.E);
        if(current_A-azimuth<=1&&current_A-azimuth>=-1&&current_E-pitch>=-1&&current_E-pitch<=1&&roll==0){
          TakePhoto(_visible_point_list.indexOf(element),current_A,current_E);
          print("# STATUS 200 PHOTO CAPTURED");
        }
      });

    });
  }

  @override
  void dispose() {
    if (_streamSubscriptions != null) {
      _streamSubscriptions.cancel();
    }
    if (_streamSubscriptions2 != null) {
      _streamSubscriptions2.cancel();
    }
    _controller.dispose();
    super.dispose();
  }
  void initializeCamera() async{
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    setState(() {
      _controller = camera_.CameraController(
          firstCamera, camera_.ResolutionPreset.high);
      _initialiseControllerFuture = _controller.initialize();
    });

  }

  Widget build(BuildContext context) {
    final camera_model = Provider.of<CameraModel>(context);
     return Scaffold(
        backgroundColor: Color.fromRGBO(97, 97, 97, 1),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 70),
              child: roll!=0?Container(
                width: 50,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: AssetImage("assets/rotate.jpg"),
                        fit: BoxFit.cover

                    )
                ),
              ):Container(),

            ),
            CustomPaint(
              foregroundPainter: MyPainter(
                  pitch: pitch,
                  screen: MediaQuery.of(context).size,
                  azimuth: azimuth,
                  roll: roll,
                  n: number,
                  ImgList: _imglist,
                  cameramodal: camera_model,
                  list: _list,
                  img: imgframelist,
                  visible_list: _visible_point_list),
              child: FutureBuilder<void>(
                future: _initialiseControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return number==0? Container(
                     margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*(1-1/2.2)/2,horizontal:MediaQuery.of(context).size.width*(1-1/1.8)/2),
                      child: camera_.CameraPreview(_controller),
                    ):Container();
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 30),
                child: number!=0?CustomPaint(
                    foregroundPainter: ProgressPainer(number/15),
                    child:   GestureDetector(
                      onTap: () async{
                       if (number == 1) {
                          _controller.dispose();
                 await ProcessImage(imagepaths: _imglist,
                              camera_modal: camera_model,size: MediaQuery.of(context).size).Process();

                          //                          Navigator.push(context, MaterialPageRoute(
//                              builder: (BuildContext context) =>
//                                  ));
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Center(child: number==15?Icon(Icons.check,color: Colors.green,size: 30,):
                        Text("${((number*100)/15).toInt()}%",style: TextStyle(fontSize: 18),)
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black,blurRadius: 5.0)
                            ]
                        ),
                      ),
                    )
                ):Container(
                  child: Text("Point the camera at the dot",style: TextStyle(color: Colors.white,fontSize: 20,),),
                ),
              ),
            ),
          ],
        )
    );
  }

  void TakePhoto(int index,int current_A,int current_E) async {
    await _initialiseControllerFuture;
    final path =
    join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    await _controller.takePicture(path);
    print("#1 STATUS 200 IMAGE CAPTURED");
    setState(() {
      Image_set _set =Image_set(azimuth:current_A,elevation:current_E,Imagepath: path);
      _imglist.add(_set);
    });
    var img= await loadUiImage(number);
    setState(() {
      imgframelist.add(img);
      number++;
      _visible_point_list.removeAt(index);
    });
    _list.forEach((element) {
      var _listA=int.parse(element.A);
      var _listE=int.parse(element.E);
      if(_listA-current_A==0&&_listE-current_E==0){
        print("#3 STATUS 200");
        setState(() {
          list_index=_list.indexOf(element);
        });
        print("#4 STATUS 200");
        return null;
      }
    });
    setState(() {
      _list.removeAt(list_index);
    });
    print("#5 STATUS 200 ${_list.length}");
    _list.forEach((element) {
      var _listA=int.parse(element.A);
      var _listE=int.parse(element.E);
      if((_listA-current_A<40&&(_listA-current_A>0)&&(_listE-current_E)==0)
          ||(_listA-current_A>-40&&(_listA-current_A<0)&&(_listE-current_E)==0)
          ||(_listA-current_A==0&&(_listE-current_E)<25&&(_listE-current_E)>0)
          ||(_listA-current_A==0&&(_listE-current_E)>-25&&(_listE-current_E)<0)){
        print("#6 STATUS 200");
        setState(() {
          if(!_visible_point_list.contains(element)) {
            _visible_point_list.add(element);
          }
        });
      }

    });
    print("#7 STATUS 200 ${_visible_point_list.length} & ${_list.length}");
    _visible_point_list.forEach((element) {
      print("${element.A} & ${element.E}");
    });
  }
  Future<ui.Image> loadUiImage(int k) async {
    final data2= await File(_imglist[k].Imagepath).readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data2, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}

class ProgressPainer extends CustomPainter {
  final prgress;

  ProgressPainer(this.prgress);
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    Paint pt= new Paint()
      ..color=Colors.green
      ..style=PaintingStyle.stroke
      ..strokeWidth=10;
    canvas.drawArc(Rect.fromCircle(center:Offset(size.width/2,size.height/2),radius: 35), -pi/2, pi*prgress*2, false, pt);
    // canvas.drawCircle(Offset(size.width/2,size.height/2), 32, pt);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Image_set {
  final Imagepath;
  final azimuth;
  final elevation;
  Image_set({this.elevation, this.azimuth, this.Imagepath});
}

class Points {
  final A;
  final E;
  Points({this.A, this.E});
}
