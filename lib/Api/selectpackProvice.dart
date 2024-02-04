import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class selectpackProvices {
  selectpackProvices();

  Future<http.Response> selectpackProvicesApi(proviceID) {
    final String Url = "${Mydomain.testNode}/ApiRouters/selectpackProvice/$proviceID";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
