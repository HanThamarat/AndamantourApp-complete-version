import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class reserveForm extends StatefulWidget {
  List list;
  int index;

  final String? userID;
  final String? firstName;
  final String? lastName;
  final int? TotalPrice;

  reserveForm({
    super.key,
    required this.list,
    required this.index,
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.TotalPrice,
  });

  @override
  State<reserveForm> createState() => _reserveFormState();
}

class _reserveFormState extends State<reserveForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [Text("${widget.TotalPrice}")],
        ),
      ),
    );
  }
}
