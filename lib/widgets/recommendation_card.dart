import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.activity,
    required this.notes,
    required this.startDate,
    required this.daysDuration,
  });

  final String activity;
  final String notes;
  final String startDate;
  final int daysDuration;

  FaIcon _getActivityIcon() {
    IconData iconData;

    switch (activity) {
      case 'SEDENTARY':
        iconData = FontAwesomeIcons.person;
        break;
      case 'WALKING':
        iconData = FontAwesomeIcons.personWalking;
        break;
      case 'JOGGING':
        iconData = FontAwesomeIcons.personRunning;
        break;
      case 'RUNNING':
        iconData = FontAwesomeIcons.personRunning;
        break;
      case 'CYCLING':
        iconData = FontAwesomeIcons.personBiking;
        break;

      default:
        iconData = FontAwesomeIcons.person;
    }

    return FaIcon(
      iconData,
      color: Colors.white,
      size: 28,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 4,
        color: const Color.fromRGBO(28, 109, 241, 1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _getActivityIcon(),
                  const SizedBox(width: 10),
                  Text(
                    activity,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                notes,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text(
                            "Issued on:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            startDate,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Days to do:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$daysDuration day(s).",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.add_card,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
