import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rendezvous/api/get_programs.dart';
import 'package:rendezvous/inc/Constants.dart';
import 'package:rendezvous/inc/common.dart';
import 'package:rendezvous/models/db.dart';

class TeamChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: mainBox!.listenable(keys: [DBKeys.allTeams]),
        builder: (BuildContext context, Box box, Widget? child) {
          List teams = box.get(DBKeys.allTeams) ?? [];
          Map<String, double> dataMap = {};
          List<Color> colorList = [];
          if (teams.isNotEmpty) {
            teams.forEach((element) {
              dataMap = {
                ...dataMap,
                element['code']:
                    int.parse("${element['point'] ?? 0}").toDouble()
              };

              colorList
                  .add(Color(int.parse("0xff${element['color'] ?? 'C14332'}")));
            });
          }
          return Container(
              width: Get.width,
              child: dataMap.keys.length > 0 && colorList.isNotEmpty
                  ? Container(
                      child: PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: Get.width * 0.4,
                        colorList: colorList,
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
        });
  }
}
