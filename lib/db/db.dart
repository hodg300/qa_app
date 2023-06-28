import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/app_logger.dart';

class DB {
  // ios emulator - 127.0.0.1:3000 or localhost
  // android emulator - 10.0.2.2:3000
  // localhost on real device means different

  static String url = "http://192.168.86.68:3000";

  static Future<Map<String, dynamic>> postData({String route = "answers", required Map<String, dynamic> data}) async {
    Map<String, dynamic> responseData = {};
    try {
      final response = await http.post(
        Uri.parse(
            "$url/$route"
        ),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data),);
      if(response.statusCode == 201 || response.statusCode == 200){
        responseData = jsonDecode(response.body);
        AppLogger.log("postData - success - $route - $responseData");
      }else{
        AppLogger.error("postData - error - $route - ${response.statusCode}}");
      }
    }catch (e) {
      AppLogger.error("postData - error - $route - $e");
      return responseData;
    }
    return responseData;
  }


  /// Send GET Request - generic
  static Future<Map<String, dynamic>> getData({String route = "questions"}) async {
    Map<String, dynamic> responseData = {};
    AppLogger.log("url get data: $url/$route");
    try {
      final response = await http.get(
          Uri.parse(
              "$url/$route"),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          });
      AppLogger.log("response 22 - ${response.body} - ${response.statusCode}");
      if(response.statusCode == 201 || response.statusCode == 200){
        var res = jsonDecode(response.body);
        responseData["msg"] = "success";
        responseData["data"] = res;
        AppLogger.log("getData1 - success - $route - $responseData");
      }else{
        AppLogger.error("getData2 - error - $route - ${response.statusCode}}");
        responseData["msg"] = "failure";
      }
    }catch (e) {
      AppLogger.error("getData3 - error - $route - $e");
      responseData["msg"] = "failure";
      return responseData;
    }
    return responseData;
  }




}
