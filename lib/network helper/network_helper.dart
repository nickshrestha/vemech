import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_evert.dart';
import 'package:vemech/models/login_model.dart';
import 'package:vemech/network%20helper/base_url.dart';
import 'package:vemech/widgets/prefrences_helper.dart';

class NetworkHelper {
  final HttpWithMiddleware client = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.HEADERS),
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  String? _token; // Store the token in a private variable\
  var _header;
  TokenManager tokenManager = TokenManager();

  // Constructor to initialize the token
  NetworkHelper() {
    _initializeToken();
  }

  // Function to initialize the token by fetching it from SharedPreferences
  Future<void> _initializeToken() async {
    _token = await tokenManager.getToken();
    _header = await {
      'Authentication': 'Token $_token', // Use the stored token here
    };
    print("this is token $_token");
    print("this is header $_header");
  }

  // Method to retrieve the token
  String? get token => _token;

  parseUrl(String url) {
    try {
      var parsedUrl = Uri.parse(url);
      return parsedUrl;
    } catch (e) {
      throw e;
    }
  }

  // Example: GET request
  Future<String> getData() async {
    try {
      var response = await client.get(parseUrl("BaseUrl.login"));
      return response.toString();
    } catch (e) {
      throw e;
    }
  }

  // POST login request with username and password
  Future<http.Response> postLogin(
      {required String username, required String password}) async {
    try {
      http.Response response = await client.post(parseUrl(BaseUrl.login),
          body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }

  // POST logout request, using the token stored in the class
  Future<http.Response> postLogout() async {
    try {
      http.Response response = await client.post(
        parseUrl(BaseUrl.logout),
        headers: _header,
      );

      // Check the response status
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('An error occurred during logout: $e');
    }
  }

  Future<http.Response> postChangePassword(
      {required currentPassword,
      required newPassword,
      required confirmPassword}) async {
    try {
      var bodyResponse = {
        "current_password": currentPassword,
        "new_password": newPassword,
        "confirm_password": confirmPassword
      };
      http.Response response = await client.post(
          parseUrl(BaseUrl.changePassword),
          headers: _header,
          body: bodyResponse);

      // Check the response status
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('An error occurred during logout: $e');
    }
  }

  // POST SignUp request
  Future<http.Response> postSignUp({
    required String role,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String address,
    required String phoneNo,
    required String dob,
  }) async {
    try {
      var body = {
        "role": role,
        "email": email,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "confirm_password": confirmPassword,
        "address": address,
        "phone_no": phoneNo,
        "dob": dob,
      };
      http.Response response =
          await client.post(parseUrl(BaseUrl.signup), body: body);
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('An error occurred during signup: $e');
    }
  }

  Future<http.Response> getProfile() async {
    try {
      http.Response response = await client.get(
        parseUrl(BaseUrl.userprofile),
        headers: _header,
      );

      // Check the response status
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('An error occurred during logout: $e');
    }
  }

  // Observe network connectivity
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        NetworkBloc().add(NetworkNotify(isConnected: false));
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
