import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/bookingsApi.dart';
import 'package:fluttertest/Api/deleteReserve.dart';
import 'package:fluttertest/LoginScreen/Login_Screen.dart';
import 'package:fluttertest/Screens/reserveScreen/reserveDetail.dart';
import 'package:fluttertest/domain.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class reserveScreen extends StatefulWidget {
  const reserveScreen({super.key});
  static const String routeName = 'reserve';

  @override
  State<reserveScreen> createState() => _reserveScreenState();
}

class _reserveScreenState extends State<reserveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Bookings"),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: null,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(child: listBookings()),
        ]),
      ),
    );
  }
}

class listBookings extends StatefulWidget {
  const listBookings({super.key});

  @override
  State<listBookings> createState() => _listBookingsState();
}

class _listBookingsState extends State<listBookings> {
  bool IscheckPacktype = true;
  bool CheckChild = false;
  bool IscheckCharter = true;

  @override
  void initState() {
    super.initState();
    selectBookings();
  }

  booKings list_bookings = booKings();

  Future selectBookings() async {
    // ignore: unnecessary_null_comparison
    if (GetStorage().read('userID') == null) {
      setState(() {
        LoginSceen();
      });
    } else {
      int UserID = GetStorage().read('userID');
      var response = await list_bookings.bookingApis(UserID);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('select data success : ${data}');
        return data;
      } else {
        print('not data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: selectBookings(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Container(
                  child: new ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      final date = DateFormat.d().format(
                          DateTime.parse(list.elementAt(index)['date_travel']));
                      final month = DateFormat.MMM().format(
                          DateTime.parse(list.elementAt(index)['date_travel']));

                      if (list.elementAt(index)['image_payment'] == null) {
                        IscheckPacktype = true;
                      } else {
                        IscheckPacktype = false;
                      }

                      for (var i = 0;i < list.elementAt(index)['packtypeID'];i++) {
                        print(i);
                        if (i == 0) {
                          IscheckCharter = true;
                        } else {
                          IscheckCharter = false;
                        }
                      }
                      return Container(
                        padding: EdgeInsets.only(),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              new CupertinoPageRoute(
                                  builder: (context) => new reserveDetail(
                                    list: list,
                                    index: index
                                  )),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${list.elementAt(index)['image']}"),
                                                    )),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        "${list.elementAt(index)['packName']}",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Kanit',
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .location_on),
                                                              Text(
                                                                "${list.elementAt(index)['name_en']}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  child: IscheckPacktype
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            await showDialog(context: context,
                                                                builder:(context) => DialogAlert(
                                                                    reserveID: list.elementAt(index)['reserveID'],
                                                                  ));
                                                            setState(() {
                                                              selectBookings();
                                                            });
                                                          },
                                                          child: Icon(Icons
                                                              .delete_forever_outlined))
                                                      : Container()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 0.0, right: 0.0),
                                              child: Divider(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: IscheckCharter
                                            ? Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .directions_boat_filled,
                                                          color: Colors.blue,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          month,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors.blue,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          date,
                                                          style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors.blue,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "THB ${list.elementAt(index)['total_price']}",
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .directions_boat_filled,
                                                          color: Colors.blue,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "${list.elementAt(index)['quantity_adult']} x Adult",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Kanit',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${list.elementAt(index)['quantity_child']} x Child",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Kanit',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        month,
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        date,
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "THB ${list.elementAt(index)['total_price']}",
                                                        style: TextStyle(
                                                            fontFamily: 'Kanit',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
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
        });
  }
}

// ignore: must_be_immutable
class DialogAlert extends StatelessWidget {
  int reserveID;

  DialogAlert({required this.reserveID, super.key});

  delete_Reserve delete_reserves = delete_Reserve();

  Future deleteReserve(dynamic reserveID) async {
    var response = await delete_reserves.deleteReserves(reserveID);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('delect success : $data');
    } else {
      print('error delete');
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
              "Are you sure want to remove this from your bookings?",
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
                    await deleteReserve(reserveID);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      border: Border.all(color: GlobalColors.mainColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Yes, remove it",
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
