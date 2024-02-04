import 'dart:convert';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class selectReviewApis {
  selectReviewApis();

  Future<http.Response> selectReview_Apis() async {
    final String Url = "${Mydomain.testNode}/ApiRouters/selectReview";
    final uri = Uri.parse(Url);
    final headersApi = {"Content-Type": "application/json"};

    return http.get(uri, headers: headersApi);
  }
}
