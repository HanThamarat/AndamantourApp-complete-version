import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertest/Api/promotionApi.dart';
import 'package:fluttertest/Api/quantitybook.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:fluttertest/Screens/cartScreen/cartScreen.dart';
import 'package:fluttertest/Screens/packageScreen/reviewPackage.dart';
import 'package:fluttertest/Screens/reserveScreen/reserveCharter.dart';
import 'package:fluttertest/Screens/reserveScreen/reverve_step.dart';
import 'package:fluttertest/Screens/reserveScreen/revserveScreen.dart';
import 'package:fluttertest/domain.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:get_storage/get_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class packagesDetail extends StatefulWidget {
  List list;
  int index;

  packagesDetail(
      {super.key,
      required this.list,
      required this.index,
      });

  @override
  State<packagesDetail> createState() => _packagesDetailState();
}

class _packagesDetailState extends State<packagesDetail> {


  String promotionPrice = '';
  String promotionAdult = '';
  String promotionChild = '';
  String quantityCount = '';
  bool IscheckPrice = true;
  bool IscheckPro = true;
  bool IscheckproType = true;
  

  @override
  void initState() {
    super.initState();
    quantity();
    promotion_Api();
  }

  quantityBook quantity_Book = quantityBook();
  promotions pro = promotions();

  Future quantity() async {
    int packID = widget.list[widget.index]['packID'];

    var response = await quantity_Book.quantitybookApi(packID);

    if (response.statusCode == 200) {
       final Map<String, dynamic> responseJson = json.decode(response.body);
       final Listdata = responseJson['body'];
        setState(() {
          quantityCount = Listdata[0]['quantity'].toString();
        });
    }
  }

  Future promotion_Api() async {
    int packID = widget.list[widget.index]['packID'];

    var response = await pro.promotionApis(packID);

    if (response.statusCode == 200) {
       final Map<String, dynamic> responseJson = json.decode(response.body);
       final dynamic Listdata = responseJson['body'];
       
        setState(() {
          IscheckPro = true;
        });
         if (Listdata[0]['promotionPrice_Adult'] == null || Listdata[0]['promotionPrice_Child'] == null) {
            setState(() {
              IscheckproType = true;
              promotionPrice = Listdata[0]['promotionPrice_charterBoat'].toString();
            });
         } else {
            setState(() {
              IscheckproType = false;
              promotionPrice = Listdata[0]['promotionPrice_Adult'].toString();
              promotionAdult = Listdata[0]['promotionPrice_Adult'].toString();
              promotionChild = Listdata[0]['promotionPrice_Child'].toString();
            });
         }
        print(Listdata);
    } else {
      setState(() {
        IscheckPro = false;
      });
    }
  }

  


  @override
  Widget build(BuildContext context) {
     if (widget.list[widget.index]['packPrice'] == null) {
        IscheckPrice = true;
    } else {
        IscheckPrice = false;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      // bottom navbar
      bottomNavigationBar: Container(
        // color: Colors.white,
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
        padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: CupertinoButton(
                  color: GlobalColors.mainColor,
                  onPressed: () async {
                    if (GetStorage().read('userID') == null) {
                      Navigator.of(context).push(
                        new CupertinoPageRoute(
                            builder: (context) => new LoginSceen()),
                      );
                    } else {
                      if (promotionPrice != '') {
                        if(widget.list[widget.index]['packtypeID'] == 1){
                            Navigator.of(context).push(
                            new CupertinoPageRoute(
                                builder: (context) => new reserveCharterScreen(
                                  list: widget.list,
                                  index: widget.index,
                                  proCharter: promotionPrice
                                )),
                            );
                            } else {
                              Navigator.of(context).push(
                              new CupertinoPageRoute(
                                  builder: (context) => new cartScreen(
                                      list: widget.list,
                                      index: widget.index,
                                      proAdult: promotionAdult,
                                      proChild: promotionChild
                                      )),
                                );
                            }
                      } else {
                        if(widget.list[widget.index]['packtypeID'] == 1){
                         Navigator.of(context).push(
                        new CupertinoPageRoute(
                            builder: (context) => new reserveCharterScreen(
                              list: widget.list,
                              index: widget.index, 
                              proCharter: '',
                            )),
                        );
                        } else {
                          Navigator.of(context).push(
                          new CupertinoPageRoute(
                              builder: (context) => new cartScreen(
                                  list: widget.list,
                                  index: widget.index, 
                                  proAdult: '', 
                                  proChild: '',
                                  )),
                        );
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Reserve Now",
                    style: TextStyle(
                        fontFamily: 'Kanit', color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //Appbar
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.0,
          ),
        ),
      ),
      // image header
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Image.network(
                    "${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${widget.list[widget.index]['image']}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 200.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24, left: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        IscheckPro? Container(
                                          child: Container(
                                            child:IscheckPrice? Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "THB ${widget.list[widget.index]['priceCharter']}",
                                                    style: TextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      fontFamily: "Kanit",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    "THB $promotionPrice",
                                                    style: TextStyle(
                                                      fontFamily: "Kanit",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "THB ${widget.list[widget.index]['packPrice']}",
                                                    style: TextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      fontFamily: "Kanit",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                    "THB $promotionPrice",
                                                    style: TextStyle(
                                                      fontFamily: "Kanit",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ),
                                        ) 
                                        : Container(
                                          child:IscheckPrice? Text(
                                            "THB ${widget.list[widget.index]['priceCharter']}",
                                            style: TextStyle(
                                              fontFamily: "Kanit",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ) : Text(
                                            "THB ${widget.list[widget.index]['packPrice']}",
                                            style: TextStyle(
                                              fontFamily: "Kanit",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ),
                                      Text('$quantityCount booked',style: TextStyle(fontFamily: 'Kanit',fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 16.0),
                                      child: new Text(
                                        "${widget.list[widget.index]['packName']}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Kanit'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.directions_boat_filled_rounded,
                                      size: 14.0,
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "${widget.list[widget.index]['packagesTypename']}",
                                          style: TextStyle(fontFamily: 'Kanit'),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14.0,
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          "${widget.list[widget.index]['name_en']}",
                                          style: TextStyle(fontFamily: 'Kanit'),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Padding(padding: const EdgeInsets.only(left: 16),
                                    child: GestureDetector(
                                      onTap: () async {
                                         Navigator.of(context).push(new CupertinoPageRoute(builder:(context) => new reviewScreen(list: widget.list, index: widget.index,)),);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color:GlobalColors.mainColor.withOpacity(0.2),
                                          border: Border.all(color: GlobalColors.mainColor),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.comment,size: 18, color: GlobalColors.mainColor,),
                                            SizedBox(width: 5,),
                                            Text("Review", style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w500, color: GlobalColors.mainColor,),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // line
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        child: Divider(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        child: Divider(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      color: Colors.grey[50],
                                      elevation: 0.0,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                                // color: Colors.grey.withOpacity(0.1)
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.grey.withOpacity(0.1),
                                                  GlobalColors.mainColor
                                                      .withOpacity(0.4)
                                                ])),
                                            child: Row(
                                              children: [
                                                Icon(Icons
                                                    .directions_boat_filled),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Package detail",
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // html convert to dart
                                                      Html(
                                                        data: widget.list[widget.index]['packDeteil'],
                                                        style: {
                                                          'li': Style(
                                                              fontFamily: 'Kanit', fontWeight:FontWeight.w400)
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(
                              //           left: 16.0, top: 24.0),
                              //       child: Text(
                              //         "Top Amenitiess",
                              //         style: TextStyle(
                              //             fontSize: 18.0, fontFamily: 'Kanit'),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),

                              // Container(
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //       left: 16.0,
                              //       right: 16.0,
                              //     ),
                              //     child: Column(
                              //       children: <Widget>[
                              //         Card(
                              //           color: Colors.grey[50],
                              //           elevation: 0.0,
                              //           child: Row(
                              //             children: [
                              //               Expanded(
                              //                 child: Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(20.0),
                              //                   child: Column(
                              //                     mainAxisSize:
                              //                         MainAxisSize.min,
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment.start,
                              //                     children: [
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                       Text("1.fgfgfgfgfgfgf"),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              SizedBox(
                                height: 350.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//select header
// class selectPackageHeaher extends StatefulWidget {
//   const selectPackageHeaher({super.key});

//   @override
//   State<selectPackageHeaher> createState() => _selectPackageHeaherState();
// }

// class _selectPackageHeaherState extends State<selectPackageHeaher> {
       
//   // //function select data from database
//   // Future selectPackageHeaders() async {
//   //   String Url = "${Mydomain.domain}/packageDetail.php";
//   //   final response = await http.get(Uri.parse(Url));

//   //   if (response.statusCode == 200) {
//   //     var data = json.decode(response.body);
//   //     //check response data
//   //     if (data == "Error") {
//   //       // show alert
//   //       setState(() {
//   //         showTopSnackBar(
//   //           Overlay.of(context),
//   //           CustomSnackBar.error(
//   //             message: "Something went wrong.",
//   //           ),
//   //         );
//   //       });
//   //     } else {
//   //       return data;
//   //     }
//   //   } else {
//   //     // show alert
//   //     setState(() {
//   //       showTopSnackBar(
//   //         Overlay.of(context),
//   //         CustomSnackBar.error(
//   //           message: "Something went wrong.",
//   //         ),
//   //       );
//   //     });
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0, top: 0.0),
//                 child: new Text(
//                   "${widget.list}",
//                   style: TextStyle(fontSize: 18.0, fontFamily: 'Kanit'),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, top: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(
//                   Icons.directions_boat_filled_rounded,
//                   size: 14.0,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 5.0),
//                     child: Text(
//                       "Type",
//                       style: TextStyle(fontFamily: 'Kanit'),
//                     )),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, top: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(
//                   Icons.location_on,
//                   size: 14.0,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 5.0),
//                     child: Text(
//                       "Location",
//                       style: TextStyle(fontFamily: 'Kanit'),
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }