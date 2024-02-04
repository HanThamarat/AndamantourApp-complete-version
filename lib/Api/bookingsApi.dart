import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class booKings {
  booKings();

  Future<http.Response> bookingApis(int UserID) async {
    String Url = "${Mydomain.testNode}/ApiRouters/reservelist/$UserID";

    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
