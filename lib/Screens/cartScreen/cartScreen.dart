import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/cartScreen/widget/itemBox.dart';
import 'package:fluttertest/Screens/reserveScreen/reverve_step.dart';
import 'package:fluttertest/Screens/reserveScreen/widget/reserveForm.dart';
import 'package:fluttertest/domain.dart';
import 'package:fluttertest/globalColor/global_Color.dart';

// ignore: must_be_immutable
class cartScreen extends StatefulWidget {
  List list;
  int index;

  String? proAdult;
  String? proChild;
  cartScreen(
      {super.key,
      required this.list,
      required this.index,
      required this.proAdult,
      required this.proChild,
      });

  @override
  State<cartScreen> createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  bool Ischeckcount = true;
  bool Ischeckpro = true;

  int count_Adult = 1;
  int count_Child = 0;

  late int totalAudlt;
  late int totalChild;
  late int totalPrice;

  @override
  void initState() {
    super.initState();
    checkPro();
  }

  Future checkPro() async {
    if (widget.proAdult != '' || widget.proChild != '') {
      setState(() {
        Ischeckpro = true;
      });
    } else {
      setState(() {
        Ischeckpro = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // int AudltPrice = widget.list[widget.index]['packPrice'];
    // int ChildPrice = widget.list[widget.index]['ticketKid'];

    // totalAudlt = (AudltPrice * count_Adult);
    // totalChild = (ChildPrice * count_Child);
    // totalPrice = (totalAudlt + totalChild);

    if(widget.proAdult != '' || widget.proChild != ''){
      int AudltPrice = int.parse(widget.proAdult!);
      int ChildPrice = int.parse(widget.proChild!);
      totalAudlt = (AudltPrice * count_Adult);
      totalChild = (ChildPrice * count_Child);
      totalPrice = (totalAudlt + totalChild);
    } else {
      int AudltPrice = widget.list[widget.index]['packPrice'];
      int ChildPrice = widget.list[widget.index]['ticketKid'];
      totalAudlt = (AudltPrice * count_Adult);
      totalChild = (ChildPrice * count_Child);
      totalPrice = (totalAudlt + totalChild);
    }

    if (totalPrice == 0) {
      setState(() {
        Ischeckcount = false;
      });
    } else {
      setState(() {
        Ischeckcount = true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Add Number of Visitor",
          style: TextStyle(fontFamily: 'Kanit'),
        ),
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              // itemboxWidget(list: widget.list, index: widget.index, userID: widget.userID, firstName: widget.firstName, lastName: widget.lastName,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Colors.white,
                        elevation: 0.0,
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, bottom: 16),
                                        child: Container(
                                          height: 190.0,
                                          width: 120.0,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${widget.list[widget.index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${widget.list[widget.index]['packName']}",
                                                        style: TextStyle(
                                                            fontFamily: "Kanit",
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .directions_boat_filled_rounded,
                                                        size: 14.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5.0),
                                                        child: Text(
                                                          "${widget.list[widget.index]['packagesTypename']}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Kanit"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 14.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5.0),
                                                        child: Text(
                                                            "${widget.list[widget.index]['name_en']}"),
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
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                            child: Divider(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                            child: Divider(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Adult'),
                                                  Ischeckpro ? Row(
                                                    children: [
                                                      Text('THB ${widget.list[widget.index]['packPrice']}', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12),),
                                                      SizedBox(width: 5,),
                                                      Text('THB ${widget.proAdult}', style: TextStyle(fontSize: 14),),
                                                    ],)
                                                  : Text('THB ${widget.list[widget.index]['packPrice']}'),
                                                ],
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (count_Adult == 0) {
                                                          setState(() {
                                                            count_Adult = 0;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            count_Adult--;
                                                          });
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(left: 5,right: 5),
                                                        child: Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              border: Border.all( color: Colors.blue),
                                                              borderRadius: BorderRadius.circular(5)),
                                                          child: Center(
                                                            child: Text("-", style: TextStyle(fontFamily: 'Kanit', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.blue),
                                                            borderRadius:
                                                                BorderRadius.circular(5)),
                                                        child: Center(
                                                          child: Text("$count_Adult"),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          count_Adult++;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(left: 5,right: 5),
                                                        child: Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.blue),
                                                              borderRadius:
                                                                  BorderRadius.circular(5)),
                                                          child: Center(
                                                            child: Text("+", style: TextStyle(fontFamily: 'Kanit', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Child'),
                                                  Ischeckpro ? Row(
                                                    children: [
                                                      Text('THB ${widget.list[widget.index]['ticketKid']}', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12),),
                                                      SizedBox(width: 5,),
                                                      Text('THB ${widget.proChild}', style: TextStyle(fontSize: 14),),
                                                    ],)
                                                  : Text('THB ${widget.list[widget.index]['ticketKid']}'),
                                                ],
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (count_Child == 0) {
                                                          setState(() {
                                                            count_Child = 0;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            count_Child--;
                                                          });
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5,
                                                                right: 5),
                                                        child: Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .blue),
                                                              borderRadius:
                                                                  BorderRadius.circular(5)),
                                                          child: Center(
                                                            child: Text("-", style: TextStyle(fontFamily: 'Kanit', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Center(
                                                          child: Text(
                                                              "$count_Child"),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          count_Child++;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5,
                                                                right: 5),
                                                        child: Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .blue),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Center(
                                                            child: Text("+", style: TextStyle(fontFamily: 'Kanit', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        // color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
            ]),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ToTal Price",
                  style: TextStyle(
                      fontFamily: 'Kanit', fontWeight: FontWeight.w700),
                ),
                Text(
                  "THB $totalPrice",
                  style: TextStyle(
                      fontFamily: 'Kanit', fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Ischeckcount? SizedBox(
                width: double.infinity,
                height: 45,
                child: CupertinoButton(
                  color: GlobalColors.mainColor,
                  onPressed: () async {
                    Navigator.of(context).push(
                      new CupertinoPageRoute(
                          builder: (context) => new reserveStep(
                                list: widget.list,
                                index: widget.index,
                                TotalPrice: totalPrice,
                                quantityAdult: count_Adult,
                                quantityChild: count_Child,
                              )),
                    );
                  },
                  // style: ElevatedButton.styleFrom(
                  //   elevation: 0.0,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20.0),
                  //   ),
                  // ),
                  child: const Text(
                    "Reserve Now",
                    style: TextStyle(fontFamily: 'Kanit', color: Colors.white, fontSize: 14),
                  ),
                ),
              ) : GestureDetector(
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Text("Reserve Now", style: TextStyle(fontFamily: 'Kanit', color: Colors.white, fontSize: 14),),),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
