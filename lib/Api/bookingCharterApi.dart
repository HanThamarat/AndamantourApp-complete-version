import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class bookingCharterApi {
  bookingCharterApi();

  Future<http.Response> bookingCharterApis(
    dynamic userID,
    String firstName,
    String lastName,
    String email,
    dynamic packID,
    String dateTravel,
    String phone_number,
    dynamic total_price,
    String location_hotel,
  ) async {
    final String Url = "${Mydomain.testNode}/ApiRouters/reserveCharter";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "userID": userID,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "packID": packID,
      "dateTravel": dateTravel,
      "phone_number": phone_number,
      "total_price": total_price,
      "location_hotel": location_hotel
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody));
  }
}
