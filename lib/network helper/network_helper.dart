import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_evert.dart';
import 'package:vemech/models/login_model.dart';
import 'package:vemech/network%20helper/base_url.dart';

class NetworkHelper {
  final HttpWithMiddleware client = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.HEADERS),
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  parseUrl(String url) {
    try {
      var parsedUrl = Uri.parse(url);
      return parsedUrl;
    } catch (e) {
      throw e;
    }
  }

  // Example
  Future<String> getData() async {
    try {
      var response = await client.get(parseUrl("BaseUrl.login"));
      return response.toString();
    } catch (e) {
      throw e;
    }
  }

  Future<Response> postLogin(
      {required String username, required String password}) async {
    try {
      Response response = await client.post(parseUrl(BaseUrl.login),
          body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        // var jsonMap = json.decode(response.body);
        return response;
      } else {
        return response;
        // Handle other status codes as needed (e.g., 401, 404)
        // throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }

  Future<Response> postSignUp({
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
      Response response =
          await client.post(parseUrl(BaseUrl.signup), body: body);
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }

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
