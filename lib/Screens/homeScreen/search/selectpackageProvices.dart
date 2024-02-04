import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/homeScreen/search/widget/list_dataProvice.dart';

class selectpackageProvice extends StatefulWidget {
  int proviceIDs;
  selectpackageProvice({
    super.key,
    required this.proviceIDs
  });

  @override
  State<selectpackageProvice> createState() => _selectpackageProviceState();
}

class _selectpackageProviceState extends State<selectpackageProvice> {
  @override
  Widget build(BuildContext context) {
    return listdataPackprovice( proviceIDs: widget.proviceIDs,);
  }
}
