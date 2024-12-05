import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // Private constructor for singleton
  TokenManager._();

  // Singleton instance
  static final TokenManager _instance = TokenManager._();

  factory TokenManager() {
    return _instance;
  }

  String? _token;

  // Retrieve token from SharedPreferences and store it in the instance variable
  Future<String?> getToken() async {
    if (_token == null) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
    }
    return _token;
  }

  // Save token to SharedPreferences and store it in the instance variable
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _token = token;
  }

  // Clear the token from SharedPreferences and reset the instance variable
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = null;
  }
}
