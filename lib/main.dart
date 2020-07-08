
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solar04/Camerascreen.dart';
import 'package:solar04/Resultpage.dart';
import 'package:solar04/modals/CameraModel.dart';
import 'modals/Input.dart';
import 'modals/sunModel.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Input>(create: (context) => Input()),
        ChangeNotifierProvider<Sun>(create: (context) => Sun()),
        ChangeNotifierProvider<CameraModel>(create: (context) => CameraModel()),

      ],
      child: MyApp(),
    ));
  }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel("get");

  @override
  Widget build(BuildContext context) {
    final camera_model = Provider.of<CameraModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body:SafeArea(
     child: Center(
       child: GestureDetector(
         onTap: (){
           getcameradata(camera_model);
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Camera_screen()));
         },
         child: Container(
           width: 100,
           height: 50,
           color: Color.fromRGBO(7, 9, 32, 1),
           child: Center(
             child: Text("proceed",style: TextStyle(color: Colors.white),),
           ),
         ),
       ),
     )),
     );
   }
  void getcameradata(cameramodal)async{
    try {
      var result1 = await platform.invokeMethod("get");
      cameramodal.set_focus((result1*100).toInt());
    } on PlatformException catch (e) {
      print('unable to get focal length ${e}');
    }
    try {
      var result2 = await platform.invokeMethod("horizon");
      cameramodal.set_Horizontal(result2);
    } on PlatformException catch (e) {
      print('unable to get vertical ${e}');
    }
    try {
      var result3 = await platform.invokeMethod("vert");
      cameramodal.set_Vertical(result3);
    } on PlatformException catch (e) {
    }
  }


}