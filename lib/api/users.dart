String getAllUsersEmails() {
  String query = """
  {
    users {
      email
    }
  }
  """;

  return query;
}

String getUserAuthToken() {
  String query = """
  mutation loginMutation(\$email: String!, \$password: String!) {
    loginUser(input: {email: \$email, password: \$password}) {
      token
    }
  }
  """;

  return query;
}
