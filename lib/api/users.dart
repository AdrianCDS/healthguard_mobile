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

String createAndGetUserAuthToken() {
  String query = """
  mutation registerMutation(\$email: String!, \$password: String!, \$firstName: String!, \$lastName: String!, \$cnp: String!, \$doctorEmail: String!) {
    registerPacient(
      input: {
        email: \$email
        password: \$password
        firstName: \$firstName
        lastName: \$lastName
        pacientProfile: {
          cnp: \$cnp
        }
        medicEmail: \$doctorEmail
      }
    ) {
      token
    }
  }
  """;

  return query;
}

String deleteUserAuthToken() {
  String query = """
  mutation logoutMutation(\$token: String!) {
    logoutUser(input: {token: \$token}) {
      token
    }
  }
  """;

  return query;
}

String getUserInfo() {
  String query = """
  query pacientQuery(\$token: String!) {
    getPacientByToken(token: \$token) {
      pacientProfile {
        cnp,
        state
      }
      user {
        firstName,
        lastName,
        email
      }
      medic {
        firstName,
        lastName,
        phoneNumber
      }
    }
  }
  """;

  return query;
}

String getUserRecommandations() {
  String query = """
  query recommandationsQuery(\$token: String!) {
    getPacientByToken(token: \$token) {
      pacientProfile {
        recommandations { recommandation, note, daysDuration, startDate, activityType { type } }
      }
    }
  }
  """;

  return query;
}

String getUserAlerts() {
  String query = """
  query alertsQuery(\$token: String!) {
    getPacientByToken(token: \$token) {
      pacientProfile {
        healthWarnings { minValue, maxValue, type, triggered, triggeredDate, activityType { type }}
      }
    }
  }
  """;

  return query;
}

String getUserLastReadData() {
  String query = """
  query lastDataQuery(\$token: String!) {
    getPacientLastReadSensorDataByToken(token: \$token) {
      type,
      value
    }
  }
  """;

  return query;
}

String getUserCurrentChartData() {
  String query = """
  query chartDataQuery(\$token: String!, \$date: DateTime!) {
    getPacientSensorDataByDatetime(token: \$token, date: \$date) {
      bpm,
    	temperature,
    	ecg,
    	humidity
    }
  }
  """;

  return query;
}

String getUserChartData() {
  String query = """
  query chartDataQuery(\$token: String!, \$date: DateTime!) {
    getPacientSensorDataByDate(token: \$token, date: \$date) {
      bpm,
    	temperature,
    	ecg,
    	humidity
    }
  }
  """;

  return query;
}

String getUserCurrentActivityData() {
  String query = """
  query activityProgressQuery(\$token: String!, \$date: DateTime!) {
    getPacientCurrentActivityStats(token: \$token) {
      completedPercentage
    	endDate
    	type
    }
    getPacientActivitiesByDate(token: \$token, date: \$date) {
    	completedPercentage
    	endDate
    	type
  	}
  }
  """;

  return query;
}

String getUserActivityData() {
  String query = """
  query getUserActivityData(\$token: String!, \$date: DateTime!) {
    getPacientActivitiesByDate(token: \$token, date: \$date) {
    	completedPercentage
    	endDate
    	type
  	}
    getUserByToken(token: \$token) {
    	pacientProfile {activityType {type}}
  	}
  }
  """;

  return query;
}

String changeUserActivity() {
  String query = """
  mutation getUserActivityData(\$token: String!, \$activity: ActivityTypeEnum!) {
 	  updatePacientActivityType(activityType: {type: \$activity}, token: \$token) {
  	  pacientProfile {activityType {type}}
	  }
  }
  """;

  return query;
}
