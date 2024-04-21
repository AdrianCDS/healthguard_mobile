import 'package:flutter_dotenv/flutter_dotenv.dart';

String getApiEndpoint() {
  return dotenv.env['API_ENDPOINT'].toString();
}

String getApiKey() {
  return dotenv.env['API_KEY'].toString();
}
