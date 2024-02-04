import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertest/Api/cancelBooking.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class calcelBooking extends StatefulWidget {
  int reserveID;
  calcelBooking({
    super.key,
    required this.reserveID
    });

  @override
  State<calcelBooking> createState() => _calcelBookingState();
}

class _calcelBookingState extends State<calcelBooking> {
  bool IscheckLoading = true;

   final spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 30,
  );
  
  final formkey = GlobalKey<FormState>();
  TextEditingController bankName = TextEditingController();
  TextEditingController bankFirstLastName = TextEditingController();
  TextEditingController bankNumber = TextEditingController();

  cancelBooking cancel_Booking = cancelBooking();

  Future reqCancelbooking() async {
    if(formkey.currentState!.validate()){
      setState(() {
        IscheckLoading = false;
      });
      final response = await cancel_Booking.cancelBookingAPI(widget.reserveID, bankName.text, bankNumber.text, bankFirstLastName.text);
      if(response.statusCode == 200) {
        Navigator.pop(context);
        setState(() {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: "Send calcel booking success.",
              ),
            );
        });
      } else {
        setState(() {
          IscheckLoading = true;
          showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "Send calcel booking error.",
              ),
            );
        });
      }
    } else {
      setState(() {
        IscheckLoading = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcel booking"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Form(
                  key: formkey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Text("การยกเลิกการจองจะต้องยกเลิกก่อนออกเดินท่าง 5-6 ชั่วโมง", style: TextStyle(fontFamily: 'Kanit'),),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Text("ชื่อธนาคาร", style: TextStyle(fontFamily: 'Kanit'))
                          ],
                        ),
                         TextFormField(
                            controller: bankName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาใส่ชื่อธนาคาร';
                              } else  {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(fontFamily: 'Kanit'),
                                hintText: "กรุณาใส่ชื่อธนาคาร",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                 contentPadding: EdgeInsets.only(left: 10)),
                          ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("เลขบัญชีธนาคาร", style: TextStyle(fontFamily: 'Kanit'))
                          ],
                        ),
                         TextFormField(
                            controller: bankNumber,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาใส่เลขบัญชีธนาคาร';
                              } else  {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(fontFamily: 'Kanit'),
                                hintText: "กรุณาใส่เลขบัญชีธนาคาร",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                 contentPadding: EdgeInsets.only(left: 10)),
                          ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("ชื่อ-นามสกุล ตรงตามเลขบัญชีธนาคาร", style: TextStyle(fontFamily: 'Kanit'))
                          ],
                        ),
                         TextFormField(
                            controller: bankFirstLastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาใส่ชื่อ-นามสกุล';
                              } else  {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(fontFamily: 'Kanit'),
                                hintText: "กรุณาใส่ชื่อ-นามสกุล",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                 contentPadding: EdgeInsets.only(left: 10)),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(top: 16, bottom: 16),
                            child: SizedBox(
                              width: double.infinity,
                              child: CupertinoButton(
                                color: GlobalColors.mainColor,
                                onPressed: () async {
                                  await reqCancelbooking();
                                },
                                child: IscheckLoading? const Text(
                                  "Reserve Now",
                                  style: TextStyle(
                                      fontFamily: 'Kanit',
                                      color: Colors.white,
                                      fontSize: 14),
                                ) : spinkit
                              ),
                            ),
                          ),
                      ],
                    ),
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
