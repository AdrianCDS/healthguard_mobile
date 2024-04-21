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
