import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/Api/reverve_Api.dart';
import 'package:fluttertest/Screens/reserveScreen/revserveScreen.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class reserveStep extends StatefulWidget {
  List list;
  int index;

  final int? TotalPrice;
  final int? quantityAdult;
  final int? quantityChild;
  reserveStep(
      {Key? key,
      required this.list,
      required this.index,
      required this.TotalPrice,
      required this.quantityAdult,
      required this.quantityChild})
      : super(key: key);

  @override
  State<reserveStep> createState() => _reserveStepState();
}

class _reserveStepState extends State<reserveStep> {
  final formkey = GlobalKey<FormState>();

  bool IscheckLoading = true;

  TextEditingController firstName =
      TextEditingController(text: GetStorage().read('userfristName'));
  TextEditingController lastName =
      TextEditingController(text: GetStorage().read('userlastName'));
  TextEditingController Email =
      TextEditingController(text: GetStorage().read('userEmail'));
  TextEditingController phoneNumber =
      TextEditingController(text: GetStorage().read('userPhone'));
  TextEditingController _datecomtroller = TextEditingController();
  TextEditingController hotelName = TextEditingController();

  int currentStep = 0;

  reserveApi reserve_Api = reserveApi();

  final spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 30,
  );


  Future reserveReq() async {
    if(formkey.currentState!.validate()){
      try {
        var response = await reserve_Api.reserveApis(
            GetStorage().read('userID'),
            firstName.text,
            lastName.text,
            Email.text,
            widget.list[widget.index]['packID'],
            _datecomtroller.text,
            phoneNumber.text,
            widget.quantityAdult,
            widget.quantityChild,
            widget.TotalPrice,
          hotelName.text
          );
        if(response.statusCode == 201) {
          final data = await json.encode(response.body);
          print('insert data success : $data');
          setState(() {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: "Booking success.",
              ),
            );
          });
          Navigator.of(context).push(new CupertinoPageRoute(builder: (context) => new reserveScreen()),
          );
          firstName.clear();
          lastName.clear();
          Email.clear();
          phoneNumber.clear();
          hotelName.clear();
          _datecomtroller.clear();
        } else {
          print('server err');
        }
      } catch (err) {
        print('reverveReq Error : ${err}');
      }
    } else {
      print('err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill In Detaiils"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formkey,
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 10, left: 16, right: 16, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              // color: Colors.grey.withOpacity(0.1)
                              gradient: LinearGradient(colors: [
                                Colors.grey.withOpacity(0.1),
                                GlobalColors.mainColor.withOpacity(0.3)
                              ])),
                          child: Row(
                            children: [
                              Icon(Icons.location_city_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Additional information",
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Hotel name",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Kanit'),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: hotelName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาพิมพ์ชื่อโรงแรมที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                                    hintText: "กรุณาพิมพ์ชื่อโรงแรม",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 10, left: 16, right: 16, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              // color: Colors.grey.withOpacity(0.1)
                              gradient: LinearGradient(colors: [
                                Colors.grey.withOpacity(0.1),
                                GlobalColors.mainColor.withOpacity(0.3)
                              ])),
                          child: Row(
                            children: [
                              Icon(Icons.directions_boat_filled),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Booking information",
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Frist name",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Kanit'),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: firstName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาพิมพ์ชื่อจริงที่ถูกต้อง';
                                  } else if (!InputValidators.nameValidate(
                                      value)) {
                                    return 'กรุณาพิมพ์ชื่อจริงที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                                    hintText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10)),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Last name",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Kanit'),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: lastName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาพิมพ์นามสกุลที่ถูกต้อง';
                                  } else if (!InputValidators.nameValidate(
                                      value)) {
                                    return 'กรุณาพิมพ์นามสกุลที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                                    hintText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10)),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Kanit'),
                                  ),
                                ],
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: Email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาใส่อีเมล';
                                  } else if (!EmailValidator.validate(value) ||
                                      !InputEmailValidators.emailValidate(
                                          value)) {
                                    return 'กรุณาใส่อีเมลที่ถูกต้อง';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                                    hintText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10)),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Phone number",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Kanit'),
                                  ),
                                ],
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phoneNumber,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาใส่เบอร์โทรศัพท์';
                                  } else if (value.length < 10 ||
                                      !InputNumberValidators.numberValidate(
                                          value)) {
                                    return 'กรุณาใส่เบอร์โทรศัพท์ที่ถูกต้อง';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                                    hintText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10)),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: 'Kanit'),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _datecomtroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาพิมพ์วันที่';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontFamily: 'Kanit'),
                                    hintText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    prefixIcon: Icon(Icons.calendar_month),
                                    contentPadding: EdgeInsets.only(left: 10)),
                                readOnly: true,
                                onTap: () async {
                                  selectDate();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
        bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 16, top: 20, left: 16),
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Total price", style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w500),),
                Text( "THB ${widget.TotalPrice}", style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w500), ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: GlobalColors.mainColor,
                    onPressed: () async {
                      await reserveReq();
                    },
                    child:IscheckLoading? const Text(
                      "Reserve Now",
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          color: Colors.white,
                          fontSize: 14),
                    ) : spinkit
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2012),
        lastDate: DateTime(2028));

    if (_picked != null) {
      setState(() {
        _datecomtroller.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

//check input text
class InputValidators {
  static bool nameValidate(String value) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }
}

class InputNumberValidators {
  static bool numberValidate(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }
}

class InputEmailValidators {
  static bool emailValidate(String value) {
    return RegExp(r'^[a-zA-Z0-9@.]+$').hasMatch(value);
  }
}
