import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/api/users.dart' as users;
import 'package:url_launcher/url_launcher.dart';

class DashboardSettings extends StatefulWidget {
  const DashboardSettings({super.key, required this.userToken});

  final String userToken;

  @override
  State<DashboardSettings> createState() => _DashboardSettingsState();
}

class _DashboardSettingsState extends State<DashboardSettings> {
  bool isLoading = false;
  String errorMessage = "";

  final storage = const FlutterSecureStorage();

  void logoutUser(BuildContext context, String? currentToken) async {
    setState(() {
      isLoading = true;
    });

    try {
      final QueryResult result =
          await GraphQLProvider.of(context).value.mutate(MutationOptions(
                document: gql(users.deleteUserAuthToken()),
                variables: {
                  "token": currentToken,
                },
              ));

      if (result.hasException) {
        errorMessage = result.toString();
      } else {
        await storage.delete(key: "authToken");

        if (context.mounted) {
          context.goNamed("/home");
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(users.getUserInfo()),
          variables: {"token": widget.userToken}),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Center(
            child: GestureDetector(
                onTap: () {
                  logoutUser(context, widget.userToken);
                },
                child: Text(result.exception.toString())),
          );
        }

        if (result.isLoading) {
          return const Center(
            child: Text('Loading...'),
          );
        }

        String userEmail = result.data?['getPacientByToken']['user']['email'];
        String userFirstName =
            result.data?['getPacientByToken']['user']['firstName'];
        String userLastName =
            result.data?['getPacientByToken']['user']['lastName'];
        String userCNP =
            result.data?['getPacientByToken']['pacientProfile']['cnp'];
        String userState =
            result.data?['getPacientByToken']['pacientProfile']['state'];

        String medicFirstName =
            result.data?['getPacientByToken']['medic']['firstName'];
        String medicLastName =
            result.data?['getPacientByToken']['medic']['lastName'];
        String medicNumber =
            result.data?['getPacientByToken']['medic']['phoneNumber'];

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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "$userFirstName $userLastName",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  userEmail,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.insert_drive_file,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      userCNP,
                                      style: const TextStyle(
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
                          onTap: () async {
                            String? value =
                                await storage.read(key: "authToken");
                            if (context.mounted) {
                              logoutUser(context, value);
                            }
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
                        ),
                        errorMessage != ""
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  errorMessage,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(height: 0),
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
                          child: userState != "PENDING"
                              ? GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse("tel:$medicNumber"));
                                  },
                                  child: Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.person_3,
                                                color: Colors.blue,
                                                size: 36,
                                              ),
                                              const SizedBox(width: 6),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Dr. $medicFirstName $medicLastName",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    medicNumber,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.phone_enabled,
                                            color: Colors.green,
                                            size: 36,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const Text(
                                  "When your doctor accepts your invite, you will be able to contact him.",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
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
      },
    );
  }
}
