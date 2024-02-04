import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/Api/paymentApi.dart';
import 'package:fluttertest/Screens/reserveScreen/cancelBooking.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertest/domain.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'dart:async';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class reserveDetail extends StatefulWidget {
  List list;
  int index;

  reserveDetail({super.key, required this.list, required this.index});

  @override
  State<reserveDetail> createState() => _reserveDetailState();
}

class _reserveDetailState extends State<reserveDetail> {
  late bool IscheckPay;
  bool IscheckCancel = false;
 
  @override
  void initState() {
    super.initState();
    checkPaymemt();
    IscheckPay;
    checkCancel();
  }

  File? imageFile;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageFile = File(image.path);
      setState(() => this.imageFile = imageTemporary);
    } on PlatformException catch (err) {
      print('Failed to pick image: $err');
    }
  }

  Future checkPaymemt() async {
    if (widget.list[widget.index]['image_payment'] == null) {
      setState(() {
        IscheckPay = false;
      });
    } else {
      if (widget.list[widget.index]['status_payment'] == '0') {
        setState(() {
          IscheckPay = false;
        });
      } else {
        setState(() {
        IscheckPay = true;
      });
      }
    }
  }

  Future checkCancel() async {
    if(widget.list[widget.index]['status_cancel'] == '2') {
      setState(() {
        IscheckCancel = true;
      });
    } else {
      IscheckCancel = false;
    }
  }


  

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${widget.list[widget.index]['packName']}"),
          elevation: 1,
          leading: IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${widget.list[widget.index]['image']}"),
                          fit: BoxFit.cover
                          ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:[
                              Colors.white, 
                              Colors.white.withOpacity(0.1),
                              Colors.transparent
                             ],
                             begin: Alignment.bottomCenter,
                             end: Alignment.topCenter,
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 200),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            IscheckCancel? Container(
                              child: Text('Your reservation has been successfully canceled.', style: TextStyle(fontFamily: 'Kanit', fontSize: 18, fontWeight: FontWeight.w600),),
                            ) : Container(
                              child: IscheckPay? Text('Your booking has been paid and confirmed.', style: TextStyle(fontFamily: 'Kanit', fontSize: 18, fontWeight: FontWeight.w600),) : Text('Your booking is in process of confirming payment.', style: TextStyle(fontFamily: 'Kanit', fontSize: 18, fontWeight: FontWeight.w600),),
                              ),
                            SizedBox(height: 10,),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                      )
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text("Booking number", style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w500),),
                                          SizedBox(height: 5,),
                                          Text("${widget.list[widget.index]['reserveID']}", style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w700),),
                                        ],
                                      ),
                                      )
                                    ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.directions_boat_filled_outlined),
                                          SizedBox(width: 5,),
                                          Text(DateFormat.d().format(DateTime.parse(widget.list[widget.index]['date_travel'])), style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w700),),
                                          SizedBox(width: 5,),
                                          Text(DateFormat.MMM().format(DateTime.parse(widget.list[widget.index]['date_travel'])), style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w700),),
                                          SizedBox(width: 5,),
                                          Text(DateFormat.y().format(DateTime.parse(widget.list[widget.index]['date_travel'])), style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w700),),
                                        ],
                                      ),
                                    )
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IscheckCancel? Container() : Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Center(
                  child: Column(
                    children: [
                    SizedBox(
                      height: 10,
                    ),
                    IscheckPay
                        ? Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text("ท่านได้ชำระเงินแล้ว", style: TextStyle(fontFamily: 'Kanit',fontSize: 16, fontWeight: FontWeight.w500),)
                                  ),
                                Container(
                                  width: double.infinity,
                                  height: 450,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network("${Mydomain.testNode}/paymentImage/${widget.list[widget.index]['image_payment']}", fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Text("ชำระแล้วทั้งหมด ${widget.list[widget.index]['total_price']} บาท"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: GlobalColors.mainColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    child: Center(
                                        child: Text("Cancel booking")),
                                    onTap: () async {
                                      Navigator.of(context).push(new CupertinoPageRoute(builder: (context) => new calcelBooking(reserveID: widget.list[widget.index]['reserveID'],)),);
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,)
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text("ช่องทางการชำระเงิน", style: TextStyle(fontFamily: 'Kanit',fontSize: 16, fontWeight: FontWeight.w500),)
                                  ),
                                Container(
                                  width: double.infinity,
                                  height: 450,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: imageFile != null
                                        ? Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/payment.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Text("ที่ต้องชำระทั้งหมด ${widget.list[widget.index]['total_price']} บาท"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: GlobalColors.mainColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    child: Center(
                                        child: Text("Select Image In Galllery")),
                                    onTap: () async {
                                      pickImage();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: GlobalColors.mainColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    child: Center(child: Text("Upload image")),
                                    onTap: () async {
                                      await showDialog(context: context, builder: (context) => DialogAlert(
                                        list: widget.list, 
                                        index: widget.index, 
                                        imageFile: imageFile
                                        ));
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Booking information", style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text("Name of person booking", style: TextStyle(fontFamily: 'Kanit', color: Colors.grey.shade500,),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text("${widget.list[widget.index]['firstName']} ${widget.list[widget.index]['lastName']}", style: TextStyle(fontFamily: 'Kanit',),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        child: Divider(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        child: Divider(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text("Location", style: TextStyle(fontFamily: 'Kanit', color: Colors.grey.shade500,),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text("${widget.list[widget.index]['location_hotel']}", style: TextStyle(fontFamily: 'Kanit',),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,)
                  ]
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}


class DialogAlert extends StatefulWidget {
  List list;
  int index;

  File? imageFile;

  DialogAlert({
    super.key,
    required this.list,
    required this.index,
    required this.imageFile
  });

  @override
  State<DialogAlert> createState() => _DialogAlertState();
}

class _DialogAlertState extends State<DialogAlert> {

  uploadPayments upload_payment = uploadPayments();

  Future uploadPayment() async {
    final reserveID = widget.list[widget.index]['reserveID'];

    if (widget.imageFile == null) {
      setState(() {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Please enter image.",
          ),
        );
      });
    } else {
      String base64Image = base64Encode(widget.imageFile!.readAsBytesSync());
      String fileName = widget.imageFile!.path.split('/').last;
      final response = await upload_payment.paymentApi(base64Image, fileName, reserveID);

      if (response.statusCode == 200) {
        setState(() {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Upload image success.",
          ),
        );
      });
        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure want to upload image?",
              style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: GlobalColors.mainColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "No, go back",
                      style: TextStyle(
                          fontFamily: 'Kanit', color: GlobalColors.mainColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await uploadPayment();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      border: Border.all(color: GlobalColors.mainColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Yes, upload it",
                      style:
                          TextStyle(fontFamily: 'Kanit', color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}