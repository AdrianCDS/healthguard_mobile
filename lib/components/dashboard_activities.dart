import 'package:flutter/material.dart';
import 'package:healthguard_mobile/widgets/recommendation_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/api/users.dart' as users;

class DashboardActivities extends StatefulWidget {
  const DashboardActivities({super.key, required this.userToken});

  final String userToken;

  @override
  State<DashboardActivities> createState() => _DashboardActivitiesState();
}

class _DashboardActivitiesState extends State<DashboardActivities> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(users.getUserRecommandations()),
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

        List? recommendations = result.data?['getPacientByToken']
            ['pacientProfile']['recommandations'];

        if (recommendations == null) {
          return const Center(
            child: Text(
              "Couldn't read your recommendations.",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          );
        }

        if (recommendations.isEmpty) {
          return const Center(
            child: Text(
              "No recommendations found.",
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
                  "Doctor's recommendations",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: ListView.builder(
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final recommendation = recommendations[index];

                        String notes = recommendation['recommandation'];
                        String activity = recommendation['activityType'] != null
                            ? recommendation['activityType']['type']
                            : "Unspecified";
                        String startDate = recommendation['startDate'];
                        int daysDuration = recommendation['daysDuration'];

                        return RecommendationCard(
                          activity: activity,
                          notes: notes,
                          startDate: startDate,
                          daysDuration: daysDuration,
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
