import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/widgets/chart.dart';
import 'package:healthguard_mobile/api/users.dart' as users;
import 'package:intl/intl.dart';
import 'package:healthguard_mobile/utils/helpers.dart' as helpers;

class DashboardStats extends StatefulWidget {
  const DashboardStats({super.key, required this.userToken});

  final String userToken;

  @override
  State<DashboardStats> createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  int _selectedDate = 0;

  String todayShifted = helpers.getLastSevenDaysShifted().elementAt(0);

  void changeDay(index) {
    setState(() {
      _selectedDate = index;
      todayShifted = helpers.getLastSevenDaysShifted().elementAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(users.getUserChartData()),
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
            result.data?['getPacientSensorDataByDate']?['bpm'];
        List? lastReadTemperatureData =
            result.data?['getPacientSensorDataByDate']?['temperature'];
        List? lastReadHumidityData =
            result.data?['getPacientSensorDataByDate']?['humidity'];
        List? lastReadEcgData =
            result.data?['getPacientSensorDataByDate']?['ecg'];

        List<double> bpmChartData =
            helpers.computeSingleChartData(lastReadBpmData);
        List<double> temperatureChartData =
            helpers.computeSingleChartData(lastReadTemperatureData);
        List<double> humidityChartData =
            helpers.computeSingleChartData(lastReadHumidityData);
        List<double> ecgChartData =
            helpers.computeSingleChartData(lastReadEcgData);

        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: helpers.getLastSevenDays().length,
                  itemBuilder: ((context, index) {
                    String currentDate = DateFormat('dd EE')
                        .format(helpers.getLastSevenDays()[index]);

                    bool selected = index == _selectedDate;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                            backgroundColor:
                                selected ? Colors.red : Colors.white,
                            foregroundColor:
                                selected ? Colors.white : Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          changeDay(index);
                        },
                        child: Text(currentDate),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Heart rate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Chart(
                          data: bpmChartData,
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Temperature',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Chart(
                          data: temperatureChartData,
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Humidity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Chart(
                          data: humidityChartData,
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'ECG',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Chart(
                          data: ecgChartData,
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
