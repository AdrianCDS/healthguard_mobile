import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthguard_mobile/widgets/chart.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/api/users.dart' as users;
import 'package:healthguard_mobile/utils/helpers.dart' as helpers;

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key, required this.userToken});

  final String userToken;

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  DateTime today = DateTime.now();
  String todayShifted = helpers
      .computeCurrentDate(DateTime.now().subtract(const Duration(hours: 3)));

  int _selectedIndex = 0;

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  void changeCard(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(users.getUserCurrentChartData()),
          variables: {"token": widget.userToken, "date": todayShifted}),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Center(
            child: Text(result.exception.toString()),
          );
        }

        if (result.isLoading) {
          return const Center(
            child: Text('Loading...'),
          );
        }

        List? lastReadBpmData =
            result.data?['getPacientSensorDataByDatetime']?['bpm'];
        List? lastReadTemperatureData =
            result.data?['getPacientSensorDataByDatetime']?['temperature'];
        List? lastReadHumidityData =
            result.data?['getPacientSensorDataByDatetime']?['humidity'];

        var currentBpm = helpers.isListAvailable(lastReadBpmData)
            ? lastReadBpmData?.last
            : "-";
        var currentTemperature =
            helpers.isListAvailable(lastReadTemperatureData)
                ? lastReadTemperatureData?.last
                : "-";
        var currentHumidity = helpers.isListAvailable(lastReadHumidityData)
            ? lastReadHumidityData?.last
            : "-";

        List<double> chartData = helpers.computeChartData(_selectedIndex,
            lastReadBpmData, lastReadTemperatureData, lastReadHumidityData);

        return Query(
          options: QueryOptions(
              fetchPolicy: FetchPolicy.cacheFirst,
              document: gql(users.getUserCurrentActivityData()),
              variables: {
                "token": widget.userToken,
                "date": helpers.computeCurrentDate(
                    _selectedDay.subtract(const Duration(hours: 3)))
              }),
          builder: (result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(
                child: Text(result.exception.toString()),
              );
            }

            if (result.isLoading) {
              return const Center(
                child: Text('Loading...'),
              );
            }

            int completedPercentage =
                result.data?['getPacientCurrentActivityStats'] == null
                    ? 0.0
                    : result.data?['getPacientCurrentActivityStats']
                        ['completedPercentage'];

            String activity =
                result.data?['getPacientCurrentActivityStats'] == null
                    ? ""
                    : result.data?['getPacientCurrentActivityStats']['type'];

            String? dateString =
                result.data?['getPacientCurrentActivityStats'] == null
                    ? null
                    : result.data?['getPacientCurrentActivityStats']['endDate'];

            DateTime? endDate =
                dateString == null ? null : DateTime.parse(dateString);

            int activitiesCount =
                result.data?['getPacientActivitiesByDate'] == null
                    ? 0
                    : result.data?['getPacientActivitiesByDate'].length;

            return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 316,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 62, 130, 238),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: 316,
                            child: TableCalendar(
                              rowHeight: 34,
                              locale: "en_US",
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) {
                                return isSameDay(day, _selectedDay);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                _onDaySelected(selectedDay, focusedDay);
                              },
                              headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  leftChevronIcon: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                  titleTextStyle:
                                      TextStyle(color: Colors.white)),
                              calendarStyle: const CalendarStyle(
                                  todayTextStyle:
                                      TextStyle(color: Colors.white),
                                  outsideTextStyle:
                                      TextStyle(color: Colors.white54),
                                  defaultTextStyle:
                                      TextStyle(color: Colors.white)),
                              daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekdayStyle:
                                      TextStyle(color: Colors.white54),
                                  weekendStyle:
                                      TextStyle(color: Colors.white54)),
                              firstDay: DateTime.utc(today.year, 1, 1),
                              lastDay: DateTime.utc(today.year, 12, 31),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        'You have $activitiesCount activities recommended by your doctor to do on the selected day.',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Color.fromRGBO(6, 40, 96, 1)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 8),
                          child: Text(
                            helpers.selectedDataToPreview(_selectedIndex),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 16, top: 16, bottom: 8),
                          child: Container(
                              width: 96,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 62, 130, 238),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('dd MMM').format(_selectedDay),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Container(
                        height: 130,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Chart(
                            data: chartData,
                          ),
                        )),
                    const SizedBox(height: 9),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 130,
                            child: GestureDetector(
                              onTap: () {
                                changeCard(0);
                              },
                              child: Card(
                                elevation: 4,
                                color: _selectedIndex == 0
                                    ? const Color.fromARGB(255, 251, 78, 66)
                                    : Colors.grey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.heartPulse,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Heart rate',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      currentBpm.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 124,
                            height: 130,
                            child: GestureDetector(
                              onTap: () {
                                changeCard(1);
                              },
                              child: Card(
                                elevation: 4,
                                color: _selectedIndex == 1
                                    ? const Color.fromARGB(255, 62, 130, 238)
                                    : Colors.grey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.temperatureHalf,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Temperature',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      currentTemperature.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 124,
                            height: 130,
                            child: GestureDetector(
                              onTap: () {
                                changeCard(2);
                              },
                              child: Card(
                                elevation: 4,
                                color: _selectedIndex == 2
                                    ? const Color.fromARGB(255, 26, 54, 102)
                                    : Colors.grey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.droplet,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Humidity',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      currentHumidity.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
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
                        child: endDate != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        activity,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        'Due ${DateFormat('dd MMM, yyyy').format(endDate)}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${completedPercentage.toString()} % completed',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        // Background of the progress bar
                                        Container(
                                          width: double.infinity,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        // Foreground of the progress bar
                                        FractionallySizedBox(
                                          widthFactor:
                                              completedPercentage / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : activity != ""
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            activity,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const Text(
                                        'There are is no set target from your doctor for this activity.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'No activity detected.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}
