import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:healthguard_mobile/pages/dashboard.dart';
import 'package:healthguard_mobile/pages/homepage.dart';
import 'package:healthguard_mobile/pages/login.dart';
import 'package:healthguard_mobile/pages/register.dart';
import 'package:healthguard_mobile/api/graphql_client.dart' as graphql_client;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
// import 'package:healthguard_mobile/utils/auth.dart' as auth;

void main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: '.env');
  } else {
    await dotenv.load(fileName: '.env.development');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphql_client.getClient(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
    initialLocation: "/home",
    // redirect: (context, state) {
    //   auth.isAuthenticated().then((isAuthenticated) {
    //     if (isAuthenticated) {
    //       return "/dashboard";
    //     } else {
    //       return "/home";
    //     }
    //   });

    //   return null;
    // },
    routes: <RouteBase>[
      GoRoute(
          name: "/home",
          path: "/home",
          builder: (context, state) {
            return const Homepage();
          }),
      GoRoute(
          name: "/register",
          path: "/register",
          builder: (context, state) {
            return const Register();
          }),
      GoRoute(
          name: "/login",
          path: "/login",
          builder: (context, state) {
            return const Login();
          }),
      GoRoute(
          name: "/dashboard",
          path: "/dashboard",
          builder: (context, state) {
            return const Dashboard();
          }),
    ]);
