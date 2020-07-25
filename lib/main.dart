import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar04/modals/CameraModel.dart';
import 'package:solar04/screens/wrapper.dart';
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
    child: MyApp(
    ),
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
      home: Wrapper(),
    );
  }
}
