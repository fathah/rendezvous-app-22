import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';

import 'Functions/getAPIData.dart';

class TeamChart extends StatefulWidget {
  @override
  _TeamChartState createState() => _TeamChartState();
}

class _TeamChartState extends State<TeamChart> {
  Map<String, double>? dataMap;
  List<Color>? colorList;

  setChartData() {
    List teamScores = mainBox!.get('teamScore') ?? [];
    setState(() {
      dataMap = {
        teamScores[0]['team'].toUpperCase(): teamScores[0]['score'] != null
            ? teamScores[0]['score'].toDouble()
            : 0,
        teamScores[1]['team'].toUpperCase(): teamScores[1]['score'] != null
            ? teamScores[1]['score'].toDouble()
            : 0,
        teamScores[2]['team'].toUpperCase(): teamScores[2]['score'] != null
            ? teamScores[2]['score'].toDouble()
            : 0,
      };
      colorList = [
        getThemeColor(teamScores[0]['team']),
        getThemeColor(teamScores[1]['team']),
        getThemeColor(teamScores[2]['team'])
      ];
    });
  }

  @override
  void initState() {
    if (mainBox!.get('teamScore') != null &&
        mainBox!.get('teamScore').runtimeType != String) {
      setChartData();
    } else {
      getProgramsFromAPI().then((value) {
        setChartData();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        child: dataMap != null
            ? Container(
                child: PieChart(
                  dataMap: dataMap!,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: Get.width * 0.4,
                  colorList: colorList!,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 20,
                  legendOptions: LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: true,
                    decimalPlaces: 0,
                  ),
                ),
              )
            : Center(
                child: Text("Loading"),
              ));
  }
}
