import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/edituserApi.dart';
import 'package:fluttertest/Api/updateProfileApi.dart';
import 'package:fluttertest/RegisterScreen/register_Screen.dart';
import 'package:fluttertest/domain.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class editPersonal extends StatefulWidget {
  List list;
  int index;
  editPersonal({
    super.key,
    required this.list,
    required this.index
    });

  @override
  State<editPersonal> createState() => _editPersonalState();
}

class _editPersonalState extends State<editPersonal> {
  final formkey = GlobalKey<FormState>();
  File? imageFile;

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemporary = File(image.path);
      imageFile = File(image.path);
      setState(() => this.imageFile = imageTemporary);
    }catch(err){
      print('Failed to pick image: $err');
    }
  }

  updateProfiles update_pro = updateProfiles();

  edituser edit_user = edituser();

  Future updateProfile_Api() async {
    final userID = widget.list[widget.index]['userID'];

    if (imageFile == null) {
      if(formkey.currentState!.validate()){
        final response = await edit_user.edituserApis(firstname.text, lastname.text, email.text, phoneNumber.text, userID);

        if(response.statusCode == 200) {
          Navigator.pop(context);
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: "Update data success.",
            ),
          );
        } else {
          print('server err');
        }
      } else {
        print('err');
      }
    } else {
      String base64Image = base64Encode(imageFile!.readAsBytesSync());
      String fileName = imageFile!.path.split('/').last;
      final response = await update_pro.updateProfileApis(base64Image, fileName, userID);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Update data success.",
          ),
        );
      } else {
        setState(() {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: "Server Error.",
            ),
          );
        });
      }
    }
  }

  TextEditingController firstname = TextEditingController(text: GetStorage().read('userfristName'));
  TextEditingController lastname = TextEditingController(text: GetStorage().read('userlastName'));
  TextEditingController email = TextEditingController(text: GetStorage().read('userEmail'));
  TextEditingController phoneNumber = TextEditingController(text: GetStorage().read('userPhone'));
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontFamily: 'Kanit'),),
        centerTitle: true,
        leading: IconButton(onPressed: () async {
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back_ios_new_rounded)
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageFile != null ? Image.file(imageFile!, fit: BoxFit.cover,) : Image.network("${Mydomain.testNode}/userImage/${widget.list[widget.index]['user_image']}", fit: BoxFit.cover,)
                          )
                        ),
                        onTap: () async {
                          pickImage();
                        },
                      ),
                      SizedBox(height: 5,),
                      Container(
                        child: Text("Profile image", style: TextStyle(fontFamily: 'Kanit', color: Colors.grey),),
                      ),
                      SizedBox(height: 20,),
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
                          controller: firstname,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาพิมพ์ชื่อจริงที่ถูกต้อง';
                            } else if (!InputValidators.nameValidate(value)) {
                              return 'กรุณาพิมพ์ชื่อจริงที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'Kanit'),
                              hintText: "กรุณาพิมพ์ชื่อ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.only(left: 10)),
                        ),
                        SizedBox(height: 10,),
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
                          controller: lastname,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาพิมพ์นามสกุลที่ถูกต้อง';
                            } else if (!InputValidators.nameValidate(value)) {
                              return 'กรุณาพิมพ์นามสกุลที่ถูกต้อง(ภาษาอังกฤษเท่านั้น)';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'Kanit'),
                              hintText: "กรุณาพิมพ์นามสกุล",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.only(left: 10)),
                        ),
                        SizedBox(height: 10,),
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
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาพิมพ์อีเมลที่ถูกต้อง';
                            }  else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'Kanit'),
                              hintText: "กรุณาพิมพ์อีเมล",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.only(left: 10)),
                        ),
                        SizedBox(height: 10,),
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
                          controller: phoneNumber,
                          validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาใส่เบอร์โทรศัพท์';
                                } else if (value.length < 10 || !InputNumberValidators.numberValidate(value)) {
                                  return 'กรุณาใส่เบอร์โทรศัพท์ที่ถูกต้อง';
                                } else {
                                  return null;
                                }
                              },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontFamily: 'Kanit'),
                              hintText: "กรุณาพิมพ์ชื่อ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.only(left: 10)),
                        ),
                        SizedBox(height: 10,),
                      Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: GlobalColors.mainColor,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("Save",style: TextStyle(fontFamily: 'Kanit', fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),)),
                              ),
                              onTap: () async {
                                updateProfile_Api();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
