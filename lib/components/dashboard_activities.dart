import 'package:flutter/material.dart';
import 'package:healthguard_mobile/widgets/recommendation_card.dart';

class DashboardActivities extends StatelessWidget {
  const DashboardActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 28, top: 48),
            child: Text(
              "Doctor's recommandations",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          RecommendationCard(
            activity: "Running",
            notes:
                "Do series of 1 minute sprint with 5 minutes rest in between - totaling 20 minutes of running",
            startDate: "9 April, 2024",
            endDate: "9 April, 2024",
          ),
          RecommendationCard(
            activity: "Walking",
            notes: "Walk everyday for at least 30 minutes",
            startDate: "9 April, 2024",
            endDate: "9 April, 2024",
          ),
        ],
      ),
    );
  }
}
