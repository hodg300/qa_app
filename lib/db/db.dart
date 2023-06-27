import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/app_logger.dart';

class DB {
  static String url = "http://localhost:3000/";

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
  static Future<Map<String, dynamic>> getData({String route = "questions", bool backupIp = false}) async {
    Map<String, dynamic> responseData = {};
    AppLogger.log("url get data: $route");
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
        responseData = jsonDecode(response.body);
        AppLogger.log("getData1 - success - $route - $responseData");
      }else{
        AppLogger.error("getData2 - error - $route - ${response.statusCode}}");
      }
    }catch (e) {
      AppLogger.error("getData3 - error - $route - $e");
      return responseData;
    }
    return responseData;
  }




}
