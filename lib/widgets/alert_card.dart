import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertCard extends StatelessWidget {
  const AlertCard(
      {super.key,
      required this.alert,
      required this.activity,
      required this.active,
      required this.min,
      required this.max,
      required this.val,
      required this.triggerDate});

  final String alert;
  final String activity;
  final bool active;
  final double min;
  final double max;
  final double val;
  final DateTime triggerDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 4,
        color: active
            ? const Color.fromRGBO(6, 40, 96, 1)
            : const Color.fromRGBO(10, 64, 154, 1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        alert,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "($activity)",
                        style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  active
                      ? const Icon(
                          Icons.warning,
                          color: Color.fromRGBO(237, 62, 62, 1),
                          size: 28,
                        )
                      : const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 28,
                        ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text(
                            "Minimum:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            min.toString(),
                            style: TextStyle(
                                color: active
                                    ? Colors.red[300]
                                    : Colors.green[300],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Current:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            val.toString(),
                            style: TextStyle(
                                color: active ? Colors.red : Colors.green[600],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Maximum:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            max.toString(),
                            style: TextStyle(
                                color: active
                                    ? Colors.red[300]
                                    : Colors.green[300],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      active
                          ? Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Triggered on: ${DateFormat('dd EEEE yyyy').format(triggerDate)}",
                                  style: TextStyle(
                                      color: Colors.red[500],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
