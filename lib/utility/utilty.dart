import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class Utility {
  static Utility? utility;

  static Utility? getInstance() {
    if(utility == null) {
      utility = Utility();
    }

    return utility;
  }


  Future<String> checkNetwork() async {
    var checkNetwork = await Connectivity().checkConnectivity();

    if(checkNetwork == ConnectivityResult.mobile) {
      return 'mobile';
    } else if(checkNetwork == ConnectivityResult.wifi) {
      return 'wifi';
    } else if(checkNetwork == ConnectivityResult.ethernet) {
      return 'ethernet';
    } else if(checkNetwork == ConnectivityResult.none) {
      return 'null';
    } else {
      return 'null';
    }
  }
}
