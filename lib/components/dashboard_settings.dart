import 'package:flutter/material.dart';
import 'package:healthguard_mobile/utils/auth.dart' as auth;

class DashboardSettings extends StatelessWidget {
  const DashboardSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(28, 109, 241, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 48, bottom: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "John Doe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "john.doe@gmail.com",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Bucharest, Romania",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            )
                          ],
                        ),
                        Image.asset(
                          "images/pacient_profile.png",
                          width: 128,
                          height: 64,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        auth.logout();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: const Row(
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            size: 34,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Log out",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 28, top: 28),
                      child: Text(
                        "My doctor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Card(
                          elevation: 4,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person_3,
                                      color: Colors.blue,
                                      size: 36,
                                    ),
                                    SizedBox(width: 6),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Dr. Michael Knorozov",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "0772827192",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.phone_enabled,
                                  color: Colors.green,
                                  size: 36,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "images/bubble_artwork.png",
                  height: 256,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
