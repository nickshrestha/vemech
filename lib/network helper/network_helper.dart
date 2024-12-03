import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:vemech/bloc/connection/connection_bloc.dart';
import 'package:vemech/bloc/connection/connection_evert.dart';

class NetworkHelper {
  final HttpWithMiddleware client = HttpWithMiddleware.build(
      middlewares: [HttpLogger(logLevel: LogLevel.HEADERS)]);

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
      var response = await client.get(parseUrl('/<addedUrl>'));
      return response.toString();
    } catch (e) {
      throw e;
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
