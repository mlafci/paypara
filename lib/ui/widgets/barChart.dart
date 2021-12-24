import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';

class BarChartGroup extends StatefulWidget {
  const BarChartGroup({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartGroupState();
}

class BarChartGroupState extends State<BarChartGroup> {
  Color leftBarColor = ColorManager.instance.blue;
  Color rightBarColor = ColorManager.instance.pink;
  double width = 5.5;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);
    final barGroup8 = makeGroupData(7, 5, 12);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utility.dynamicHeight(0.21),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Utility.dynamicWidth(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (_a, _b, _c, _d) => null,
                      ),
                      touchCallback: (FlTouchEvent event, response) {
                        if (response == null || response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }

                        touchedGroupIndex = response.spot.touchedBarGroupIndex;

                        setState(() {
                          if (!event.isInterestedForInteractions) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                            return;
                          }
                          showingBarGroups = List.of(rawBarGroups);
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (var rod in showingBarGroups[touchedGroupIndex].barRods) {
                              sum += rod.y;
                            }
                            final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

                            showingBarGroups[touchedGroupIndex] = showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                return rod.copyWith(y: avg);
                              }).toList(),
                            );
                          }
                        });
                      }),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: SideTitles(showTitles: false),
                    topTitles: SideTitles(showTitles: false),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => TextStyle(
                        color: Color(0xff7589a2),
                        fontFamily: TextStyleManager.instance.regular,
                        fontSize: Utility.dynamicHeight(0.015),
                      ),
                      margin: 10,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'May';
                          case 1:
                            return 'Haz';
                          case 2:
                            return 'Tem';
                          case 3:
                            return 'Ağu';
                          case 4:
                            return 'Eyl';
                          case 5:
                            return 'Eki';
                          case 6:
                            return 'Kas';
                          case 7:
                            return 'Ara';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => TextStyle(
                        color: Color(0xff7589a2),
                        fontFamily: TextStyleManager.instance.regular,
                        fontSize: Utility.dynamicHeight(0.015),
                      ),
                      margin: 0,
                      reservedSize: 25,
                      interval: 1,
                      getTitles: (value) {
                        if (value == 0) {
                          return '1K';
                        } else if (value == 5) {
                          return '5K';
                        } else if (value == 10) {
                          return '10K';
                        } else if (value == 15) {
                          return '15K';
                        } else if (value == 19) {
                          return '20K';
                        } else {
                          return '';
                        }
                      },
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }
}
