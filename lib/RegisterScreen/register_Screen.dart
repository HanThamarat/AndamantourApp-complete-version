import 'dart:convert';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/Api/register_Api.dart';
import 'package:fluttertest/Screens/climateScreen/utils/custom_colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../domain.dart';
import '../globalColor/global_Color.dart';
import 'package:flutter_animate/flutter_animate.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  @override
  // ให้ค่าทั้งหมดใน Form ทำงาน
  // ignore: override_on_non_overriding_member
  final formKey = GlobalKey<FormState>();

  //รับค่าจาก Textfromfield
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController tell = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  rigisterApi Regis_api = rigisterApi();

  //loading button
  bool _isloading = false;

  final spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 30,
  );

  Future register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
            _isloading = true;
          });
      try {
        var response = await Regis_api.doRegis(
            name.text, lastName.text, tell.text, email.text, pass.text);

        if (response.statusCode == 404) {
          setState(() {
            _isloading = false;
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "This email is already in the system.",
              ),
            );
          });
        } else {
          var responseJson = json.decode(response.body);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: LoginSceen()));
        }
      } catch (err) {
        print(err);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: customColors.firstGradientColor,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "สมัครสมาชิก",
          style: TextStyle(color: Colors.black, fontFamily: 'Kanit'),
        ).animate().fade(duration: 500.ms),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(7, 8, 7, 0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Animate(
                  effects: [FadeEffect(duration: 500.ms)],
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 700),
                    decoration: new BoxDecoration(boxShadow: [
                      new BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10.0),
                    ]),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "ชื่อ",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: TextFormField(
                              controller: name,
                              obscureText: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !InputValidators.nameValidate(value)) {
                                  return 'กรุณาพิมพ์ชื่อจริงที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                                }
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontFamily: "Kanit"),
                                  hintText: 'ชื่อ',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0)),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "นามสกุล",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: TextFormField(
                              obscureText: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !InputValidators.nameValidate(value)) {
                                  return 'กรุณาพิมพ์นามสกุลจริงที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontFamily: "Kanit"),
                                  hintText: 'นามสกุล',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0)),
                              controller: lastName,
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "เบอร์โทรศัพท์",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              obscureText: false,
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
                                  hintStyle: TextStyle(fontFamily: "Kanit"),
                                  hintText: 'เบอร์โทรศัพท์',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0)),
                              controller: tell,
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "อีเมล",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: TextFormField(
                              // keyboardType: TextInputType.emailAddress,
                              obscureText: false,
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
                                  hintStyle: TextStyle(fontFamily: "Kanit"),
                                  hintText: 'อีเมล',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0)),
                              controller: email,
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "รหัสผ่าน",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !InputPassValidators.passValidate(value)) {
                                  return 'กรุณาพิมพ์รหัสผ่านที่ถูกต้อง';
                                } else if (value.length < 8) {
                                  return 'กรุณาพิมพ์รหัสผ่านมากกว่า 8 ตัวอักษร';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontFamily: "Kanit"),
                                  hintText: 'รหัสผ่าน',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0)),
                              controller: pass,
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "ยืนยันรหัสผ่าน",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 5.0),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !InputPassValidators.passValidate(value)) {
                                  return 'กรุณาพิมพ์รหัสผ่านที่ถูกต้อง';
                                } else if (value != pass.text) {
                                  return 'กรุณาพิมพ์รหัสผ่านให้ตรงกัน';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontFamily: "Kanit"),
                                  hintText: 'ยืนยันรหัสผ่าน',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 46.0,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          register();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0, backgroundColor: GlobalColors.mainColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                        child: _isloading? spinkit : Text(
                                                "สมัครสมาชิก",
                                                style: TextStyle(
                                                    fontFamily: 'Kanit',
                                                    // fontSize: 20.0,
                                                    color: Colors.white),
                                              )),
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
              ],
            ),
          ),
        ),
      ),
    );
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

class InputPassValidators {
  static bool passValidate(String value) {
    return RegExp(r'^[a-zA-Z0-9@._-]+$').hasMatch(value);
  }
}
