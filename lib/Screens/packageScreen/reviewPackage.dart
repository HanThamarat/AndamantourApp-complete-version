import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/Api/reviewApi.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class reviewScreen extends StatefulWidget {
  List list;
  int index;

  reviewScreen({super.key, required this.list, required this.index});

  @override
  State<reviewScreen> createState() => _reviewScreenState();
}

class _reviewScreenState extends State<reviewScreen> {
  final formkey = GlobalKey<FormState>();
  File? imageFile;
  bool isloading = false;

  TextEditingController comentDetail = TextEditingController();

  reviews review_api = reviews();

  final UserID = GetStorage().read('userID');

  int? _rating;

  final spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 30,
  );

  Future review_Apis() async {
    if (UserID == null) {
      Navigator.of(context).push(
        new CupertinoPageRoute(builder: (context) => new LoginSceen()),
      );
    } else {
      if (formkey.currentState!.validate()) {
        setState(() {
          isloading = true;
        });
        if (imageFile == null) {
          if (_rating == null) {
            setState(() {
              isloading = false;
            });
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "rating is required.",
              ),
            );
          } else {
            final base64Image = null;
            final fileName = null;
            final response = await review_api.reviewApi(
                widget.list[widget.index]['packID'],
                UserID,
                _rating.toString(),
                comentDetail.text,
                base64Image,
                fileName);
            if (response.statusCode == 201) {
              final data = json.decode(response.body);
              print(data);
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: "Review success.",
                ),
              );
              return Navigator.pop(context);
            } else {
              print('inser data err');
            }
          }
        } else {
          if (_rating == null) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "rating is required.",
              ),
            );
          } else {
            String base64Image = base64Encode(imageFile!.readAsBytesSync());
            String fileName = imageFile!.path.split('/').last;
            final response = await review_api.reviewApi(
                widget.list[widget.index]['packID'],
                UserID,
                _rating.toString(),
                comentDetail.text,
                base64Image,
                fileName);
            if (response.statusCode == 201) {
              final data = json.decode(response.body);
              print(data);
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: "Review success.",
                ),
              );
              return Navigator.pop(context);
            } else {
              print('inser data err');
            }
          }
        }
      } else {
        print('validate is null');
      }
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageFile = File(image.path);
      setState(() => this.imageFile = imageTemporary);
    } catch (err) {
      print('Failed to pick image: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Review",
          style: TextStyle(fontFamily: 'Kanit'),
        ),
        leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          "${widget.list[widget.index]['packName']}",
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        starRate(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: comentDetail,
                            minLines: 5,
                            maxLines: null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "กรุณาใส่อะไรหน่อยเกี่ยวกับทัวร์นี้";
                              }
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'Kanit'),
                              hintText: "บอกอะไรหน่อยเกี่ยวกับทัวร์นี้",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 10, top: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        GlobalColors.mainColor.withOpacity(0.2),
                                    border: Border.all(
                                        color: GlobalColors.mainColor),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Container(
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.image,
                                        color: GlobalColors.mainColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Select Image",
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.mainColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                pickImage();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        imageFile != null
                            ? Container(
                                height: 200,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: CupertinoButton(
                            color: GlobalColors.mainColor,
                            onPressed: () async {
                              review_Apis();
                            },
                            child: isloading
                                ? spinkit
                                : Text(
                                    "Comment Now",
                                    style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  starRate() {
    return RatingBar.builder(
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (rating) {
          setState(() {
            _rating = rating.toInt();
            print(rating);
          });
        });
  }
}
