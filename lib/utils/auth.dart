import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<(bool, String?)> isAuthenticated() async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "authToken");

  return (token != null, token);
}
