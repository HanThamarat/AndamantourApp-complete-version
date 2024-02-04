import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertest/assets/Nav/nav_screen.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:fluttertest/utility/utilty.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class startScreen extends StatelessWidget {
  const startScreen({super.key});

  @override
  Widget build(BuildContext context) {

    if (Utility.getInstance()!.checkNetwork() == 'none') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('มีข้อผิดพลาด'),
            content: const Text('ไม่มีการเชื่อมต่อ network'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: Text("close")
                )
            ],
          );
        },
      );
    } else {
         Timer(const Duration(seconds: 2), () {
          Get.to(NavScreen());
        });
    }
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Image(image: AssetImage('lib/img/startApp.png')),
      ),
    );
  }
}
