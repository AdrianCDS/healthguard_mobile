import 'package:flutter/material.dart';
import 'package:healthguard_mobile/widgets/alert_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/api/users.dart' as users;
import 'package:healthguard_mobile/utils/helpers.dart' as helpers;

class DashboardAlerts extends StatefulWidget {
  const DashboardAlerts({super.key, required this.userToken});

  final String userToken;

  @override
  State<DashboardAlerts> createState() => _DashboardAlertsState();
}

class _DashboardAlertsState extends State<DashboardAlerts> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(users.getUserAlerts()),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"token": widget.userToken}),
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

        List? alerts = result.data?['getPacientByToken']['pacientProfile']
            ['healthWarnings'];

        if (alerts == null) {
          return const Center(
            child: Text(
              "Couldn't read alerts.",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        if (alerts.isEmpty) {
          return const Center(
            child: Text(
              "No alerts found.",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        return Query(
          options: QueryOptions(
              document: gql(users.getUserLastReadData()),
              variables: {"token": widget.userToken}),
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

            List? lastReadData =
                result.data?['getPacientLastReadSensorDataByToken'];

            if (lastReadData == null) {
              return const Center(
                child: Text(
                  "No wearable data found.",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              );
            }

            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 28, top: 48),
                    child: Text(
                      "My alerts",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: ListView.builder(
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            final alert = alerts[index];

                            String alertType = alert['type'];
                            DateTime triggeredDate =
                                alert['triggeredDate'] == null
                                    ? DateTime.now()
                                    : DateTime.parse(alert['triggeredDate']);
                            var minValue = alert['minValue'];
                            var maxValue = alert['maxValue'];
                            String activity = alert['activityType']['type'];
                            bool triggered = alert['triggered'];

                            var dataValues = lastReadData.firstWhere(
                                (element) =>
                                    element['type'] == alertType)['value'];

                            var currentValue =
                                helpers.computeSensorData(dataValues);

                            return AlertCard(
                              alert: alertType,
                              active: triggered,
                              activity: activity,
                              min: minValue,
                              max: maxValue,
                              val: currentValue,
                              triggerDate: triggeredDate,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
