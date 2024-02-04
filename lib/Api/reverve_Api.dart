import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class reserveApi {
  reserveApi();

  Future<http.Response> reserveApis(
    int userID,
    String fristName,
    String lastName,
    String Email,
    int packID,
    String date,
    String Phone,
    int? quantityAdult,
    int? quantityChild,
    int? TotalPrice,
    String hotelName
    ) async {
    String Url = '${Mydomain.testNode}/ApiRouters/reserve';
    final uri = Uri.parse(Url);

    var headersApi = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "userID": userID,
      "firstName": fristName,
      "lastName": lastName,
      "email": Email,
      "packID": packID,
      "dateTravel": date,
      "phone_number": Phone,
      "quantity_adult": quantityAdult,
      "quantity_child": quantityChild,
      "total_price": TotalPrice,
      "location_hotel": hotelName
    };

    return http.post(uri, headers: headersApi, body: jsonEncode(reqBody));
  }
}
