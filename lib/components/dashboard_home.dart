import 'package:flutter/material.dart';
import 'package:healthguard_mobile/widgets/HeartRateChart.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';
//import 'package:syncfusion_flutter_core/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  DateTime today = DateTime.now();
  List<double> chartData = [
    50,
    70,
    90,
    120,
    100,
    80,
    110,
    77,
    130,
    99,
    89,
    104,
    180,
    190,
    100,
    123,
    77,
  ]; // Replace with your actual data
  double currentPulse = 80;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 290,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 62, 130, 238),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      height: 290,
                      child: TableCalendar(
                        rowHeight: 30,
                        calendarStyle: CalendarStyle(
                          holidayTextStyle: TextStyle(color: Colors.white),
                          weekendTextStyle: TextStyle(color: Colors.white),
                          weekNumberTextStyle: TextStyle(color: Colors.white),
                          defaultTextStyle: TextStyle(color: Colors.white),
                          selectedTextStyle: TextStyle(color: Colors.white30),
                          todayTextStyle:
                              TextStyle(backgroundColor: Colors.blue[100]),
                        ),
                        focusedDay: today,
                        firstDay: DateTime.utc(2010, 1, 1),
                        lastDay: DateTime.utc(2050, 12, 31),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Container(
                  // Pulse
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Pulse',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 210,
                ),
                Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 62, 130, 238),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              height: 130,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomChartWidget(
                data: chartData,
                pulse: currentPulse,
              ),
            )
          ],
        ));
  }
}
