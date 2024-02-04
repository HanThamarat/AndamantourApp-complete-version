import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class reviews {
  reviews();

  Future<http.Response> reviewApi(dynamic packID, dynamic userID, String star, String comment, image, fileName) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/reviewPackage";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic>? reqBody;

    if(image == null || fileName == null) {
        reqBody = {
            "packID" : packID,
            "userID" : userID,
            "star" : star,
            "comment" : comment,
        };
    } else {
        reqBody = {
            "packID" : packID,
            "userID" : userID,
            "star" : star,
            "comment" : comment,
            "image" : image,
            "fileName" : fileName
        };
    }

    return http.post(uri, headers:  headersApi, body: jsonEncode(reqBody));
  }
}
