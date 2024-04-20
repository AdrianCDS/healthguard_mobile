import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> getClient() {
  final HttpLink httpLink =
      HttpLink("https://27777b3j-4000.euw.devtunnels.ms/api/graphql");

  final AuthLink authLink =
      AuthLink(getToken: () async => 'Basic YWRtaW46YWRtaW4=');

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
