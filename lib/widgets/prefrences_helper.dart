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
  
   String? _username;
  String? _password;

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
    print("this is token saved $_token");
  }

  // Clear the token from SharedPreferences and reset the instance variable
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = null;
  }


  // General function to save, get or clear username and password
  Future<void> manageCredentials({
    String? username,
    String? password,
    String? action = 'save', // default action is 'save'
  }) async {
    final prefs = await SharedPreferences.getInstance();

    switch (action) {
      case 'save':
        if (username != null) {
          await prefs.setString('username', username);
          _username = username;
        }
        if (password != null) {
          await prefs.setString('password', password);
          _password = password;
        }
        break;

      case 'get':
        if (username != null) {
          _username = prefs.getString('username');
        }
        if (password != null) {
          _password = prefs.getString('password');
        }
        break;

      case 'clear':
        if (username != null) {
          await prefs.remove('username');
          _username = null;
        }
        if (password != null) {
          await prefs.remove('password');
          _password = null;
        }
        break;

      default:
        throw ArgumentError("Invalid action: $action. Use 'save', 'get', or 'clear'.");
    }
    print("thsi is saved value  $_username $_password");
  }
  // Get username or password from instance variable
  Future<String?> getUsername() async {
    if (_username == null) await manageCredentials(action: 'get', username: 'username');
    return _username;
  }

  Future<String?> getPassword() async {
    if (_password == null) await manageCredentials(action: 'get', password: 'password');
    return _password;
  }

}
