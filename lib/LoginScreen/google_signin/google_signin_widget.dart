import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class googleSigninWidget extends StatelessWidget {
  const googleSigninWidget({super.key, required this.imagePath, required this.Title, this.onTap});

  final String imagePath;
  final String Title;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30,
            ),
            Text(Title, style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
    );
  }
}
