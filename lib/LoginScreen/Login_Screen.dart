import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/login_Api.dart';
import 'package:fluttertest/LoginScreen/facebook_login/facebookLogin.dart';
import 'package:fluttertest/LoginScreen/google_signin/Auth_Service.dart';
import 'package:fluttertest/LoginScreen/google_signin/google_signin_widget.dart';
import 'package:fluttertest/RegisterScreen/register_Screen.dart';
import 'package:fluttertest/Screens/homeScreen/homeScreen.dart';
import 'package:fluttertest/assets/Nav/nav_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../domain.dart';
import '../globalColor/global_Color.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  //กำหนดให้ Form ทำงาน
  final formKey = GlobalKey<FormState>();

  // เก็บค่าจากForm
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();

  get plugin => null;

  loginApi login_Api = loginApi();

  //loading button
  bool isloading = false;

  bool isLoadingGoogle = false;

  final spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 30,
  );

  // Database
  Future Login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      try {
        var response = await login_Api.doLogin(email.text, Password.text);
        if (response.statusCode == 400) {
          setState(() {
            isloading = false;
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "There is no email in the system.",
              ),
            );
          });
        } else if (response.statusCode == 404) {
          setState(() {
            isloading = false;
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "Please check your password.",
              ),
            );
          });
        } else if (response.statusCode == 201) {
          setState(() async {
            final responseJson = json.decode(response.body);

            final responseData = responseJson['body'];
            final userID = responseData[0]['userID'];
            final userFirstname = responseData[0]['name'];
            final userLastname = responseData[0]['lastName'];
            final userEmail = responseData[0]['Email'];
            final userPhone = responseData[0]['Tel'];
            print(responseJson);
            await GetStorage().write('userID', userID);
            await GetStorage().write('userfristName', userFirstname);
            await GetStorage().write('userlastName', userLastname);
            await GetStorage().write('userEmail', userEmail);
            await GetStorage().write('userPhone', userPhone);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => homeScreens(
                userID: userID.toString(),
                firstName: userFirstname.toString(),
                lastName: userLastname.toString(),
              ),
            ));
            email.clear();
            Password.clear();
          });
        }
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(color: Colors.black, fontFamily: 'Kanit'),
        ).animate().fade(duration: 500.ms),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(7, 8, 7, 0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Animate(
                  effects: [
                    FadeEffect(
                      duration: 500.ms,
                    ),
                  ],
                  child: Container(
                    width: double.infinity,
                    height: 700,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'อีเมล',
                                  style: TextStyle(
                                      // fontSize: 16.0,
                                      fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            // child: textformLogin(controller: emailController),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "กรุณาใส่อีเมลที่ได้ลงทะเบียนไว้";
                                } else if (!EmailValidator.validate(value) ||
                                    !InputEmailValodalitorsLogin.emailValidator(
                                        value)) {
                                  return "กรุณาใส่อีเมลที่ได้ลงทะเบียนไว้";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontFamily: 'Kanit'),
                                hintText: "กรุณากรอกอีเมลล์ที่ลงทะเบียนไว้",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                              ),
                              controller: email,
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'รหัสผ่าน',
                                  style: TextStyle(
                                      // fontSize: 16.0,
                                      fontFamily: 'Kanit'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "กรุณาใส่รหัสผ่าน";
                                } else if (value.length < 8) {
                                  return "กรุณาใส่รหัสผ่านให้ถูกต้อง";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontFamily: 'Kanit'),
                                  hintText: 'กรุณากรอกรหัสผ่าน',
                                  prefixIcon: Icon(Icons.https),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0)),
                              controller: Password,
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
                                          Login();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0, backgroundColor: GlobalColors.mainColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                        child: isloading
                                            ? spinkit
                                            : Text(
                                                "เข้าสู่ระบบ",
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
                          Row(
                            children: [
                              Container(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    "หรือเข้าสู่ระบบด้วย",
                                    style: TextStyle(fontFamily: 'Kanit'),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 15.0),
                                    child: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: googleSigninWidget(
                                      onTap: () async {
                                        await AuthService()
                                            .processSigninWithGoogle();

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => homeScreens(
                                            userID: '',
                                            firstName: '',
                                            lastName: '',
                                          ),
                                        ));
                                      },
                                      imagePath:
                                          'assets/signin-google/Android/png@2x/neutral/android_neutral_rd_na@2x.png',
                                      Title: 'Google'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 46,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: registerScreen()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.0, backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          side: BorderSide(color: Colors.blue),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  "สมัครสมาชิก",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ))
                                          ],
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

//check textformfield input
class InputEmailValodalitorsLogin {
  static bool emailValidator(String value) {
    return RegExp(r'^[a-zA-Z0-9@._-]+$').hasMatch(value);
  }
}

class InputPassValidatorsLogin {
  static bool passValidate(String value) {
    return RegExp(r'^[a-zA-Z0-9@._-]+$').hasMatch(value);
  }
}
