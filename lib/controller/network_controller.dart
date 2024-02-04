import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/climateScreen/utils/custom_colors.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  //fuction parameters checking connect internet
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: Text(
          "Please connect to the internet",
          style: TextStyle(
              fontFamily: 'Kanit', fontSize: 16.0, color: Colors.white,),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: customColors.firstGradientColor,
        icon: const Icon(
          Icons.wifi_off_rounded,
          color: Colors.white,
          size: 35.0,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
