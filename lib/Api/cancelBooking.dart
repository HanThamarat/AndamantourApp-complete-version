import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class cancelBooking {
  cancelBooking();

  Future<http.Response> cancelBookingAPI(reserveID, bankName, bankNumber, bankFristLastName) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/cancelBooking";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
          "reserveID": reserveID,
          "bankName": bankName,
          "bankNumber": bankNumber,
          "bankFristLastName":  bankFristLastName
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody));
  }
}
