import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  /// Check internet connection before making an api call to avoid
  /// throwing [SocketException] (can't catch the exception)
  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn;
  }
}
