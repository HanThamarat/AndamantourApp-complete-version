import 'dart:convert';
import 'dart:io';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class updateProfiles {
  updateProfiles();

  Future<http.Response> updateProfileApis(image, imageName, userID) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/updateProfile";
    final uri = Uri.parse(Url);

    final headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "image": image,
      "fileName": imageName,
      "userID": userID
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody));
  }
}
