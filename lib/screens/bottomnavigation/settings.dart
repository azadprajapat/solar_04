import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar04/utils/AppTheme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppTheme.theme1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(flex: 10,),
              Spacer(flex: 1,),
              pills("Instructions", (){}, Icon(FontAwesomeIcons.infoCircle,size: 22,color: Colors.white,),),
              Spacer(flex: 1,),
              pills("Faq", (){}, Icon(Icons.help_outline,size: 25,color: Colors.white,),),
              Spacer(flex: 1,),
              pills("Language", (){}, Icon(FontAwesomeIcons.globe,size: 22,color: Colors.white,),),
              Spacer(flex: 1,),
              pills("Feedback & suggestion", (){}, Icon(Icons.edit,size: 25,color: Colors.white,),),
              Spacer(flex: 1,),
              pills("Rate Us", (){}, Icon(Icons.star_border,size: 25,color: Colors.white,),),
              Spacer(flex: 2,)
            ],
          ),
        ),
      ),
    );
  }
  Widget pills(title,onpress,icon){
    return InkWell(
      onTap: onpress,
      child: Container(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.start,

             children: <Widget>[
               icon,
               SizedBox(width: 10,),
               Text(title,style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                   fontWeight: FontWeight.w600
               ),),
             ],
           ),
            Icon(Icons.arrow_forward_ios,size: 25,color: Colors.white,)
          ],
        ),
      ),
      
    ) ;   
  }
}
