import 'dart:convert';
import 'dart:io';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class packSale {
  packSale();

  Future<http.Response> packsaleApi() async {
    final String Url = "${Mydomain.testNode}/ApiRouters/packageSale";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
