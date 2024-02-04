import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class edituser {
  edituser();

  Future<http.Response> edituserApis(firsName, lastName, email, phoneNumber, userID) async {

    String Url = '${Mydomain.testNode}/ApiRouters/Editprofile';
    final uri = Uri.parse(Url);

    var headersApi = {
      "Content-Type": "application/json"
    };

    Map<String, dynamic> reqBody = {
        "firsName": firsName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "userID": userID
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody) );
  }
}
