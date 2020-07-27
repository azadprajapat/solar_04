import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LineChartDaily extends StatefulWidget {
  @override
  _LineChartDailyState createState() => _LineChartDailyState();
}

class _LineChartDailyState extends State<LineChartDaily> {
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
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime
                          .now()
                          .year, 1),
                      lastDate: DateTime(DateTime
                          .now()
                          .year, 12, 31),
                      initialDate: DateTime.now(),
                      locale: Locale("en"),
                    );
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("1jan - 7jan ,2020",style: TextStyle(
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

                Text("Average number of hours sun \n appear vs days in week curve",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white.withOpacity(0.6)),),
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
            switch (value.toInt()) {
              case 1:
                return 'Mon';
              case 2:
                return 'Tue';
              case 3:
                return 'Wed';
              case 4:
                return 'Thu';
              case 5:
                return 'Fri';
              case 6:
                return 'Sat';
              case 7:
              return 'Sun';
            }
            return '';
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
            return (val * 2).toInt().toString();
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
      minX: 1,
      maxX: 7,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 6),
          FlSpot(2, 5),
          FlSpot(3, 1.8),
          FlSpot(4, 1),
          FlSpot(5, 4),
          FlSpot(6, 2.2),
          FlSpot(7, 3.2),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        aboveBarData: BarAreaData(
          show: true,
          colors: [Colors.black87]
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [
            Colors.orangeAccent
          ]
        ),
      ),
    ];
  }
}
