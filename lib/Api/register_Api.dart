import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class rigisterApi {
  rigisterApi();

  Future<http.Response> doRegis(String name, String lastName, String tell,
      String email, String password) async {
    String Url = '${Mydomain.testNode}/ApiRouters/createUser';
    final uri = Uri.parse(Url);

    var headersApi = {
      "Content-Type": "application/json"
    };

    Map<String, dynamic> reqBody = {
      "name": name,
      "lastName": lastName,
      "tell": tell,
      "email": email,
      "password": password
    };

    return http.post(uri, headers: headersApi ,body: jsonEncode(reqBody));
  }
}
