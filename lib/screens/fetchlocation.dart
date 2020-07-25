import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar04/modals/CameraModel.dart';
import 'package:solar04/modals/Input.dart';
import 'package:solar04/utils/AppTheme.dart';

import 'Camerascreen.dart';

class Get_Location extends StatefulWidget {
  @override
  _Get_LocationState createState() => _Get_LocationState();
}

class _Get_LocationState extends State<Get_Location> {
  TextEditingController lat_controller;
  TextEditingController long_controller;
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final camera_model = Provider.of<CameraModel>(context);
    final input_provider=Provider.of<Input>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width-50,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(
                  flex: 70,
                ),
                Text(
                  'Lattitude',
                  style: AppTheme().body_text1,
                ),
                Spacer(
                  flex: 1,
                ),
                TextFormField(
                  key: _formkey1,
                  style: AppTheme().form_text,
                  controller: lat_controller,
                  cursorColor: AppTheme.form_textC,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 10 * MediaQuery.of(context).size.width / 360,
                          top: 5 * MediaQuery.of(context).size.height / 672),
                      hintText: '',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppTheme.button_background, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 252, 254, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.background,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'field cannot be remained empty';
                    }
                  },
                ),
                Spacer(
                  flex: 20,
                ),
                Text(
                  'longitude',
                  style: AppTheme().body_text1,
                ),
                Spacer(
                  flex: 1,
                ),
                TextFormField(
                  key: _formkey2,
                  style: AppTheme().form_text,
                  controller: long_controller,
                  cursorColor: AppTheme.form_textC,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 10 * MediaQuery.of(context).size.width / 360,
                          top: 5 * MediaQuery.of(context).size.height / 672),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppTheme.button_background, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 252, 254, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.background,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      )),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'field cannot be remained empty';
                    }
                  },
                ),
                Spacer(
                  flex: 40,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                       input_provider.setLattitude(lat_controller);
                      input_provider.setLongitude(long_controller);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Camera_screen(cameramodal: camera_model)));
                   },
                  child: Center(
                    child: Container(
                      height: 48,
                      width: 194,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Center(
                        child: Text(
                          "SUBMIT",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                        ),
                        ),
                      ),
                    ),
                  ),
                )),
                Spacer(flex: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
