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

String registerUser() {
  String query = """
  mutation registerMutation(\$email: String!, \$password: String!, \$firstName: String!, \$lastName: String!, \$cnp: String!, \$medicEmail: String!) {
      registerPacient(
        input: {
          email: \$email
          password: \$password
          firstName: \$firstName
          lastName: \$lastName
          pacientProfile: {
            cnp: \$cnp
          }
          medicEmail: \$medicEmail
        }
      ) {
        id
        email
        firstName
        lastName
        phoneNumber
        medicProfile {
          id
          badgeNumber
          pacients {
            id
            cnp
            age
          }
        }
        pacientProfile {
          id
          cnp
          age
          state
          insertedAt
          address {
            country
            city
            street
            streetNumber
          }
        medicProfile {
          id
          badgeNumber
        }
      }
    }
  }
  """;

  return query;
}
