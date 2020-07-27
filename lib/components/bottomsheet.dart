import 'package:flutter/material.dart';
import 'package:solar04/utils/AppTheme.dart';

void rootBottomSheet(context, currentindex,_list,callback) {

  showModalBottomSheet(
    context: (context),
    builder: (context) => Container(
      color: AppTheme.theme2,

      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.theme2,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(60), topLeft: Radius.circular(60))),
        padding: EdgeInsets.only(top: 20, left: 23, right: 23),
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    _list.length,
                         (index) => Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () {
                           callback(index);
                          Navigator.of(context).pop();
                                                 },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                 SizedBox(
                                  width: 10,
                                ),
                                index == currentindex ? Text(
                                  _list[index].name,
                                  style:  TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 22)): Text(
                                  _list[index].name,
                                  style:TextStyle(color: Colors.white.withOpacity(0.5),fontWeight: FontWeight.w600,fontSize: 22),
                                ),
                              ],
                            ),
                            index == currentindex     ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 25,
                            )
                                : Container()
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

