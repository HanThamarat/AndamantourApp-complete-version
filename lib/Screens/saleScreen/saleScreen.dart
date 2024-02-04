import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/saleScreen/listdata_widget.dart';

class saleScreen extends StatefulWidget {
  const saleScreen({super.key});
  static const String routeName = '/sale';

  @override
  State<saleScreen> createState() => _saleScreenState();
}

class _saleScreenState extends State<saleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package sale", style: TextStyle(fontFamily: 'Kanit'),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios_new_rounded)
          ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: selectPackageSale(),
              )
            ],
          ),
        ),
      ),
    );
  }
}


