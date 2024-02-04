import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class delete_Reserve {
  delete_Reserve();

  Future<http.Response> deleteReserves(dynamic reserveID) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/reserveCancel";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};
    Map<String, dynamic> reqData = {
      "reserveID": reserveID
      };

    return http.post(uri, headers: headersApi,body: jsonEncode(reqData));
  }
}
