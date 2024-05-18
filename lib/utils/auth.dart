import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> isAuthenticated() async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "authToken");

  return token != null;
}

Future<void> logout() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: "authToken");
}
