import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthguard_mobile/widgets/HeartRateChart.dart';
import 'package:intl/intl.dart';
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

  double currentBPM = 84;
  double currentTemperature = 36.5;
  double currentHumidity = 45.3;
  String activityType = 'Running';
  double percentage = 50;

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
  ];
  // Replace with your actual data
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
                style: const TextStyle(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 290,
                      child: TableCalendar(
                        rowHeight: 30,
                        calendarStyle: CalendarStyle(
                          holidayTextStyle:
                              const TextStyle(color: Colors.white),
                          weekendTextStyle:
                              const TextStyle(color: Colors.white),
                          weekNumberTextStyle:
                              const TextStyle(color: Colors.white),
                          defaultTextStyle:
                              const TextStyle(color: Colors.white),
                          selectedTextStyle:
                              const TextStyle(color: Colors.white30),
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
                      color: const Color.fromARGB(255, 62, 130, 238),
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
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: 110,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 251, 78, 66),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    // heart rate container
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.heartPulse,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Heart rate',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        currentBPM.toStringAsFixed(1),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const Text(
                        'BPM',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  // Tempereature container
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: 110,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 62, 130, 238),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.temperatureHalf,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Temperature',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        currentTemperature.toStringAsFixed(1),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const Text(
                        '°C',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  // Humidity container
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  width: 110,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 26, 54, 102),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.droplet,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Humidity',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        currentHumidity.toStringAsFixed(1),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const Text(
                        '%',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 9,
            ),
            Container(
              // padding: EdgeInsets.all(3),
              height: 80,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 13,
                      ),
                      Text(
                        activityType.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        width: 135,
                      ),
                      const Text(
                        'Due ',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        DateFormat('dd MMM, yyyy hh:mm a')
                            .format(today), // data cand trebuie facut exercitiu
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 13,
                      ),
                      Text(
                        percentage.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Text(
                        '% completed',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 350,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        // Background of the progress bar
                        Container(
                          width: 350, // Same as the width of the container
                          height: 15, // Same as the height of the container
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Color of the background
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                        ),
                        // Foreground of the progress bar (filling up based on percentage)
                        Container(
                          width: percentage * 3.5, // Width based on percentage
                          height: 15, // Same as the height of the container
                          // Duration of animation
                          decoration: BoxDecoration(
                            color: Colors.blue, // Color of the progress
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
