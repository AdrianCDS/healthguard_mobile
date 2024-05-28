import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/api/users.dart' as users;
import 'package:intl/intl.dart';
import 'package:healthguard_mobile/utils/helpers.dart' as helpers;

class DashboardCalendar extends StatefulWidget {
  const DashboardCalendar({super.key, required this.userToken});

  final String userToken;

  @override
  State<DashboardCalendar> createState() => _DashboardCalendarState();
}

class _DashboardCalendarState extends State<DashboardCalendar> {
  int _selectedDate = 0;

  String errorMessage = "";

  List<DateTime> dates = helpers.getLastSevenDays();
  String todayShifted = helpers.getLastSevenDaysShifted().elementAt(0);

  List<bool> radioGroup = [];

  void changeDay(index) {
    setState(() {
      _selectedDate = index;
      todayShifted = helpers.getLastSevenDaysShifted().elementAt(index);
    });
  }

  void changeActivity(
      BuildContext context, String? currentToken, String newActivity) async {
    try {
      final QueryResult result =
          await GraphQLProvider.of(context).value.mutate(MutationOptions(
                document: gql(users.changeUserActivity()),
                variables: {
                  "token": currentToken,
                  "activity": newActivity,
                },
              ));

      if (result.hasException) {
        errorMessage = result.toString();
      } else {
        return;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          document: gql(users.getUserActivityData()),
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

        if (errorMessage != "") {
          return const Center(
            child: Text('An error has occured!'),
          );
        }

        List? activityData = result.data?['getPacientActivitiesByDate'];
        String? currentActivity = result.data?['getUserByToken']
            ['pacientProfile']['activityType']?['type'];

        List<bool> initialRadioGroup =
            helpers.determineSwitchButtonsOnLoad(currentActivity);

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
                    Text(
                      'Activities for ${DateFormat('dd EE').format(dates[_selectedDate])}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: !helpers.isListAvailable(activityData)
                          ? const Text(
                              "No data.",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 6),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          'Activity',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Color.fromRGBO(
                                                  28, 109, 241, 1)),
                                        )),
                                        Expanded(
                                            child: Text(
                                          'End Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Color.fromRGBO(
                                                  28, 109, 241, 1)),
                                        )),
                                        Expanded(
                                            child: Text(
                                          'Completed',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Color.fromRGBO(
                                                  28, 109, 241, 1)),
                                        )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    SizedBox(
                                      height: 128,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: activityData?.length,
                                        itemBuilder: (context, index) {
                                          int percentage = activityData?[index]
                                              ['completedPercentage'];
                                          DateTime endDate = DateTime.parse(
                                              activityData?[index]['endDate']);
                                          String type =
                                              activityData?[index]['type'];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    type,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    DateFormat('dd MMM')
                                                        .format(endDate),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '$percentage %',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Toggle your activity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Cycling',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(6, 40, 96, 1)),
                              ),
                              Switch.adaptive(
                                value: radioGroup.isEmpty
                                    ? initialRadioGroup[0]
                                    : radioGroup[0],
                                onChanged: (bool value) {
                                  setState(() {
                                    radioGroup =
                                        helpers.switchActivityRadioButtons(0);

                                    changeActivity(
                                        context, widget.userToken, "CYCLING");
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Walking',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(6, 40, 96, 1)),
                              ),
                              Switch.adaptive(
                                value: radioGroup.isEmpty
                                    ? initialRadioGroup[1]
                                    : radioGroup[1],
                                onChanged: (bool value) {
                                  setState(() {
                                    radioGroup =
                                        helpers.switchActivityRadioButtons(1);

                                    changeActivity(
                                        context, widget.userToken, "WALKING");
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Running',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(6, 40, 96, 1)),
                              ),
                              Switch.adaptive(
                                value: radioGroup.isEmpty
                                    ? initialRadioGroup[2]
                                    : radioGroup[2],
                                onChanged: (bool value) {
                                  setState(() {
                                    radioGroup =
                                        helpers.switchActivityRadioButtons(2);

                                    changeActivity(
                                        context, widget.userToken, "RUNNING");
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Jogging',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(6, 40, 96, 1)),
                              ),
                              Switch.adaptive(
                                value: radioGroup.isEmpty
                                    ? initialRadioGroup[3]
                                    : radioGroup[3],
                                onChanged: (bool value) {
                                  setState(() {
                                    radioGroup =
                                        helpers.switchActivityRadioButtons(3);

                                    changeActivity(
                                        context, widget.userToken, "JOGGING");
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Sedentary',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(6, 40, 96, 1)),
                              ),
                              Switch.adaptive(
                                value: radioGroup.isEmpty
                                    ? initialRadioGroup[4]
                                    : radioGroup[4],
                                onChanged: (bool value) {
                                  setState(() {
                                    radioGroup =
                                        helpers.switchActivityRadioButtons(4);

                                    changeActivity(
                                        context, widget.userToken, "SEDENTARY");
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
