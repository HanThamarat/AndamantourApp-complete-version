import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class quantityBook {
  quantityBook();

  Future<http.Response> quantitybookApi(packID) async {
    String Url = '${Mydomain.testNode}/ApiRouters/quantitybook/$packID';
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
