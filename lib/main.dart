import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_client.dart' as graphql_client;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String debug = "NULL";

Future main() async {
  if (kReleaseMode) {
    debug = "RELEASE";
    await dotenv.load(fileName: '.env');
  } else {
    debug = "LOCAL";
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
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Base template application'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: double.infinity,
          child: Center(child: Text("Development Mode is $debug")),
        ),
        centerTitle: true,
      ),
      body: Query(
          options: QueryOptions(document: gql(graphql_client.getUsersQuery())),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.data == null) {
              return Center(
                child: Text(result.toString()),
              );
            }
            final users = result.data!['users'];
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final id = user['id'];
                final email = user['email'];
                return Container(
                    margin: const EdgeInsets.all(26),
                    child: Text('ID: $id, Email: $email'));
              },
            );
          }),
    );
  }
}
