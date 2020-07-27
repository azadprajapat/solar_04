import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class LineChartMonth extends StatefulWidget {
  @override
  _LineChartMonthState createState() => _LineChartMonthState();
}

class _LineChartMonthState extends State<LineChartMonth> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                InkWell(
                  onTap: (){
                    showMonthPicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year , 1),
                      lastDate: DateTime(DateTime.now().year, 12),
                      initialDate: DateTime.now(),
                      locale: Locale("en"),
                    );
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Jan",style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800
                        ),),
                        SizedBox(width: 5,),
                        Icon(FontAwesomeIcons.calendarAlt,size: 20,color: Colors.white,)
                      ],
                    ),
                  ),

                ),
                SizedBox(
                  height: 5,
                ),
                Text("Average number of hours sun\nappear vs days in month curve",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white.withOpacity(0.6)),),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData2(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return (value*5).toInt().toString();
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (val) {
            return (val*2).toInt().toString();
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 6,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1/5, 2),
          FlSpot(2/5, 5),
          FlSpot(3/5, 4),
          FlSpot(4/5, 2.5),
          FlSpot(5/5, 1.8),
          FlSpot(6/5, 2.2),
          FlSpot(10/5, 2),
          FlSpot(20/5, 5),
          FlSpot(30/5, 4),

        ],
        isCurved: true,
        curveSmoothness: 0.1,
        colors: const [
          Colors.blue,
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),

    ];
  }
}
