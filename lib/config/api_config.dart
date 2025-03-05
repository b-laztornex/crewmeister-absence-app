import 'dart:io';
import 'package:flutter/foundation.dart';

/* 
  This apiconfig set urls based on the enviroment, this could be Githubpage, IOS, Android or Localhost
*/

class ApiConfig {
  static String get baseUrl {
    const String productionUrl =
        "https://crewmeister-absence-api.onrender.com/api";

    if (kIsWeb) {
      if (Uri.base.host.contains("github.io")) {
        return productionUrl;
      } else {
        return "http://localhost:3000/api";
      }
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:3000/api";
    } else if (Platform.isIOS || Platform.isMacOS) {
      return "http://127.0.0.1:3000/api";
    } else {
      return "http://localhost:3000/api";
    }
  }
}
