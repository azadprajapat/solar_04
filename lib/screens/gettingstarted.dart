import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:solar04/modals/CameraModel.dart';
import 'package:solar04/utils/AppTheme.dart';
import 'package:solar04/utils/getcameradata.dart';
import 'package:solar04/utils/setlocation.dart';


import 'Camerascreen.dart';
import 'fetchlocation.dart';

class Get_Started extends StatefulWidget {
  @override
  _Get_StartedState createState() => _Get_StartedState();
}

class _Get_StartedState extends State<Get_Started> {
  @override
  Widget build(BuildContext context) {
    final camera_model = Provider.of<CameraModel>(context,listen: false);
    return Scaffold(
      backgroundColor: AppTheme.theme1,
        body: SafeArea(
            child: Container(
              alignment: Alignment(0,0.8),
                child: GestureDetector(
                    onTap: () async {
                      await getcameradata(camera_model);

                      final locationpermisson= await Permission.location;
                      var status= await locationpermisson.isGranted;
                      if (status) {
                        setlocation(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Camera_screen(cameramodal: camera_model)));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Get_Location()));
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 194,
                      decoration: BoxDecoration(
                        color: AppTheme.theme2,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Center(
                        child: Text(
                          "Getting started",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ))
            ))
    );
  }

}
