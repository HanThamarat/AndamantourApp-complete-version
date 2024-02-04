import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class getUser {
  getUser();

  Future<http.Response> getUsers(int userID) async {
    String Url = '${Mydomain.testNode}/ApiRouters/userGetOrder/${userID}';

    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
