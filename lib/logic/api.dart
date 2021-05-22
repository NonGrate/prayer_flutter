import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:prayer/model/prayer.dart';

const bool LOCAL = true;
const String HOST = "localhost://";

class Api {
  static final Api _api = Api._internal();
  final NetworkApi networkApi = NetworkApi();
  final LocalApi localApi = LocalApi();

  Api._internal();

  factory Api() {
    return _api;
  }

  Future<List<Prayer>> loadSelectedPrayers() async {
    var response;
    if (LOCAL) {
      response = await localApi.request(url: "api/selected_prayers");
    } else {
      response = await networkApi.request(url: "$HOST/api/selected_prayers");
    }

    return (response as List<dynamic>).map((e) => Prayer.fromJson(e)).toList();
  }

  Future<List<Prayer>> loadPrayers() async {
    var response;
    if (LOCAL) {
      response = await localApi.request(url: "api/feed");
    } else {
      response = await networkApi.request(url: "$HOST/api/feed");
    }

    return (response as List<dynamic>).map((e) => Prayer.fromJson(e)).toList();
  }

  Future<List<Prayer>> loadMyPrayers() async {
    var response;
    if (LOCAL) {
      response = await localApi.request(url: "api/my_prayers");
    } else {
      response = await networkApi.request(url: "$HOST/api/my_prayers");
    }

    return (response as List<dynamic>).map((e) => Prayer.fromJson(e)).toList();
  }
}

class NetworkApi {
  Future<dynamic> request({required String url}) async {
    print("GET request url: $url");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("$url response:");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("POST status code: ${response.statusCode}");
      throw Exception('Failed to load $url');
    }
  }

  Future<dynamic> requestPost({required String url, required Map<String, String> args}) async {
    print("POST request url: $url");
    final response = await http.post(Uri.parse(url), body: args, headers: {});

    if (response.statusCode == 200) {
      print("$url response:");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("POST status code: ${response.statusCode}");
      throw Exception("Failed to load $url");
    }
  }
}

class LocalApi {
  Future<dynamic> request({required String url}) async {
    print("GET request url: $url");
    final response = await rootBundle.loadString("$url.json");

    print("$url response:");
    print(response);

    return jsonDecode(response);
  }
}