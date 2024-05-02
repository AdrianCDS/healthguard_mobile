import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'credentials.dart' as credentials;

ValueNotifier<GraphQLClient> getClient() {
  final HttpLink httpLink = HttpLink(credentials.getApiEndpoint());

  final AuthLink authLink =
      AuthLink(getToken: () async => 'Basic ${credentials.getApiKey()}');

  final Link link = authLink.concat(httpLink);

  return ValueNotifier(GraphQLClient(link: link, cache: GraphQLCache()));
}

String getUsersQuery() {
  String query = """
    {
      users {
        id,
        email
      }
    }
  """;

  return query;
}

// import 'package:flutter/foundation.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'graphql_client.dart' as graphql_client;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// String debug = "NULL";

// if (kReleaseMode) {
//   debug = "RELEASE";
//   await dotenv.load(fileName: '.env');
// } else {
//   debug = "LOCAL";
//   await dotenv.load(fileName: '.env.development');
// }

// GraphQLProvider(
//    client: graphql_client.getClient(),
//    child: MaterialApp(
//    title: 'Flutter Demo',
//    theme: ThemeData(
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             useMaterial3: true,
//           ),
//    home: const MyHomePage(title: 'Base template application'),
// ));

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: SizedBox(
//           width: double.infinity,
//           child: Center(child: Text("Development Mode is $debug")),
//         ),
//         centerTitle: true,
//       ),
//       body: Query(
//           options: QueryOptions(document: gql(graphql_client.getUsersQuery())),
//           builder: (result, {fetchMore, refetch}) {
//             if (result.isLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (result.data == null) {
//               return Center(
//                 child: Text(result.toString()),
//               );
//             }
//             final users = result.data!['users'];
//             return ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 final user = users[index];
//                 final id = user['id'];
//                 final email = user['email'];
//                 return Container(
//                     margin: const EdgeInsets.all(26),
//                     child: Text('ID: $id, Email: $email'));
//               },
//             );
//           }),
//     );
//   }
// }
