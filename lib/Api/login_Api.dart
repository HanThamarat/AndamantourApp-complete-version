import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class loginApi {
  loginApi();

  Future<http.Response> doLogin(String email, String password) async {
    String Url = '${Mydomain.testNode}/ApiRouters/login';
    final uri = Uri.parse(Url);

    var headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "email": email,
      "password": password
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody));
  }
}
