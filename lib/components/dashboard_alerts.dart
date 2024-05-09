import 'package:flutter/material.dart';
import 'package:healthguard_mobile/widgets/alert_card.dart';

class DashboardAlerts extends StatelessWidget {
  const DashboardAlerts({super.key});

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
              "My alerts",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 6),
          AlertCard(
              activity: "Running",
              alert: "BPM",
              min: 50,
              max: 120,
              val: 132,
              date: "Today, 13:43 PM"),
        ],
      ),
    );
  }
}
