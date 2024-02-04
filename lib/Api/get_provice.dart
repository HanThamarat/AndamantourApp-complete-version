import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class provices {
  provices();

  Future<http.Response> selectProvice() async {
    final String Url = "${Mydomain.testNode}/ApiRouters/selectProvice";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
