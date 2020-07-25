import 'package:flutter/material.dart';

class AppTheme {

static   Color text_color=Color.fromRGBO(244,113,127 ,1);
static  Color button_background =Color.fromRGBO( 255, 98, 31,1);
static  Color button_textC=Color.fromRGBO(253,247,248,1);
static   Color appbar_textC=button_textC;
static   Color background=Color.fromRGBO(221, 239, 253,1);
static   Color appbar=button_background;
static   Color heading=Colors.black87;
static   Color icon_color =Color.fromRGBO(106, 159, 239,1);
static  Color form_textC=Color.fromRGBO(74,72,88,1);

final   TextStyle body_text1 = TextStyle(fontSize: 22.0, letterSpacing: 1.2, color: heading,fontWeight:FontWeight.w400);
final  TextStyle button_text = TextStyle(fontSize: 32.0, color: button_textC);
final  TextStyle form_text = TextStyle(fontSize: 20.0, color: form_textC);
final  TextStyle appbar_text = TextStyle(fontSize: 30.0, color: button_textC);
}