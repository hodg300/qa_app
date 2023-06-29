import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/app_logger.dart';

class DB {
  // iOS emulator - 127.0.0.1:3000 or localhost
  // android emulator - 10.0.2.2:3000
  // localhost on real - wifi ip - npx json-server --watch --host {WIFI-IP} db.json

  static String url = "http://192.168.0.17:3000";

  static Future<Map<String, dynamic>> postData(
      {String route = "answers", required dynamic data}) async {
    Map<String, dynamic> responseData = {};
    AppLogger.log("postData - ${json.encode(data)}");
    try {
      final response = await http.post(
        Uri.parse("$url/$route"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        var res = jsonDecode(response.body);
        responseData["msg"] = "success";
        responseData["data"] = res;
        AppLogger.log("postData - success - $route - $responseData");
      } else {
        AppLogger.error("postData - error - $route - ${response.statusCode}}");
      }
    } catch (e) {
      AppLogger.error("postData - error - $route - $e");
      responseData["msg"] = "failure";
      return responseData;
    }
    return responseData;
  }

  /// Send GET Request - generic
  static Future<Map<String, dynamic>> getData(
      {String route = "questions", String id = ""}) async {
    Map<String, dynamic> responseData = {};
    AppLogger.log("url get data: $url/$route");
    try {
      final response = await http.get(Uri.parse("$url/$route/$id"), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      AppLogger.log("response 22 - ${response.body} - ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        var res = jsonDecode(response.body);
        responseData["msg"] = "success";
        responseData["data"] = res;
        AppLogger.log("getData1 - success - $route - $responseData");
      } else {
        AppLogger.error("getData2 - error - $route - ${response.statusCode}}");
        responseData["msg"] = "failure";
      }
    } catch (e) {
      AppLogger.error("getData3 - error - $route - $e");
      responseData["msg"] = "failure";
      return responseData;
    }
    return responseData;
  }

  static Future<Map<String, dynamic>> deleteData(
      {String route = "answers", String id = ""}) async {
    Map<String, dynamic> responseData = {};
    AppLogger.log("url get data: $url/$route");
    try {
      final response =
          await http.delete(Uri.parse("$url/$route/$id"), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      AppLogger.log("response 22 - ${response.body} - ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        var res = jsonDecode(response.body);
        responseData["msg"] = "success";
        responseData["data"] = res;
        AppLogger.log("getData1 - success - $route - $responseData");
      } else {
        AppLogger.error("getData2 - error - $route - ${response.statusCode}}");
        responseData["msg"] = "failure";
      }
    } catch (e) {
      AppLogger.error("getData3 - error - $route - $e");
      responseData["msg"] = "failure";
      return responseData;
    }
    return responseData;
  }
}
