import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class promotions {
  promotions();

  Future<http.Response> promotionApis(packID) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/promotionPack/$packID";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
