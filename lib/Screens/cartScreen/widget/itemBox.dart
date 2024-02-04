import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/cartScreen/widget/cout_visitor.dart';
import 'package:fluttertest/domain.dart';
import 'package:get_storage/get_storage.dart';

class itemboxWidget extends StatefulWidget {
  List list;
  int index;

  final String? userID;
  final String? firstName;
  final String? lastName;


   itemboxWidget({
      super.key,
      required this.list,
      required this.index,
      required this.userID,
      required this.firstName,
      required this.lastName
      });

  @override
  State<itemboxWidget> createState() => _itemboxWidgetState();
}

class _itemboxWidgetState extends State<itemboxWidget> {
  final data = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
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
                            Padding(padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                              child: Container(
                                height: 190.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${widget.list[widget.index]['image']}"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0)),
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
                                          Text(
                                            "${widget.list[widget.index]['packName']}",
                                            style: TextStyle(
                                                fontFamily: "Kanit",
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500),
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
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text("${widget.list[widget.index]['packagesTypename']}", style: TextStyle(fontFamily: "Kanit"),),
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
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text("Location"),
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
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0),
                                  child: Divider(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0),
                                  child: Divider(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        countVisitorWidget(list: widget.list, index: widget.index,),
                      ],
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
