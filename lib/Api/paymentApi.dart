import 'dart:convert';
import 'dart:io';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class uploadPayments {
  uploadPayments();

  Future<http.Response> paymentApi(image, imageName, reserveID) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/uploadImagePayment";
    final uri = Uri.parse(Url);

    var headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "image": image,
      "finalName": imageName,
      "reserveID": reserveID
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody));
  }
}
