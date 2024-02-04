import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/getUsers.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:fluttertest/Screens/userScreen/Editpersonal.dart';
import 'package:fluttertest/domain.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';

class userScreen extends StatefulWidget {
  const userScreen({super.key});
  static const String routeName = '/profile';

  @override
  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen> {
  bool IsCheckLogin = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsCheckLogin;
    CheckLogin();
    userdata;
    getUserData();
  }

  getUser get_user = getUser();

  final userdata = GetStorage().read('userID');

  final data = GetStorage();

  Future CheckLogin() async {
    if (userdata == null) {
      setState(() {
        IsCheckLogin = false;
      });
    } else {
      setState(() {
        IsCheckLogin = true;
      });
    }
  }

  Future getUserData() async {
    var userID = await GetStorage().read('userID');
    if (userID == null) {
      print("user not login");
    } else {
      int UserID = GetStorage().read('userID');
      final response = await get_user.getUsers(UserID);
      if (response.statusCode == 200) {
        var data = await json.decode(response.body);
        final userResponse = await data['body'];
        print('Userdata : ${data}');
        return await userResponse;
      } else {
        print('not data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IsCheckLogin
          ? AppBar(
            title: Text("User Profile", style: TextStyle(fontFamily: 'Kanit'),),
            centerTitle: true,
          )
          : AppBar(
              elevation: 0,
              backgroundColor: GlobalColors.mainColor,
              toolbarHeight: 150.2,
              title: Container(
                child: Column(
                  children: [
                    Text(
                      "Become a member and enjoy the package tour!",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit',
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            IsCheckLogin = true;
                          });
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: LoginSceen()));
                        },
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(
                                color: Colors.white,
                                width: 0.7,
                                style: BorderStyle.solid)),
                            backgroundColor: MaterialStatePropertyAll(
                                GlobalColors.mainColor),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)))),
                        child: Text(
                          'Log In/Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit',
                              fontSize: 20.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
      body: IsCheckLogin
          ? Container(
              child: Column(
                children: [
                  FutureBuilder(
                      future: getUserData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? Container(
                                child: new ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    List list = snapshot.data;
                                    return Container(
                                      padding: EdgeInsets.only(),
                                      child: InkWell(
                                        child: Container(
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              child: Center(
                                                child: Stack(children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(
                                                                      "${Mydomain.testNode}/userImage/${list.elementAt(index)['user_image']}"),
                                                                )),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          "${list.elementAt(index)['name']} ${list.elementAt(index)['lastName']}"),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          Navigator.of(context).push(new CupertinoPageRoute(
                                                                builder:(context) => new editPersonal(
                                                                  list: list,
                                                                  index: index
                                                                )),
                                                          );
                                                        },
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Edit personal information',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 10,
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text('no data'),
                              );
                      }),
                  GestureDetector(
                    onTap: () async {
                      await GetStorage()
                          .erase()
                          .then((value) => Get.to(LoginSceen()));
                      setState(() {
                        IsCheckLogin = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                          child: Text(
                        "Logout",
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      )),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Please log in")],
              ),
            ),
    );
  }
}
