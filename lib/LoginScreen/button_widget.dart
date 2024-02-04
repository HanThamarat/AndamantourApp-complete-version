import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class buttonWidget extends StatelessWidget {
  const buttonWidget({super.key, required this.title, this.onTap});

  final String title;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Text(title),
      ),
    );
  }
}
