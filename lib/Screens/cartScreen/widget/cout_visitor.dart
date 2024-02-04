import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/cartScreen/cartScreen.dart';
import 'package:fluttertest/Screens/cartScreen/widget/calcul_price.dart';

class countVisitorWidget extends StatefulWidget {
  List list;
  int index;

  countVisitorWidget({
    super.key,
    required this.list,
    required this.index,
  });

  @override
  State<countVisitorWidget> createState() => _countVisitorWidgetState();
}

class _countVisitorWidgetState extends State<countVisitorWidget> {
  int count_Adult = 1;
  int count_Child = 0;

  late int totalAudlt;
  late int totalChild;
  late int totalPrice;

  @override
  Widget build(BuildContext context) {
    int AudltPrice = widget.list[widget.index]['packPrice'];
    int ChildPrice = widget.list[widget.index]['ticketKid'];

    totalAudlt = (AudltPrice * count_Adult);
    totalChild = (ChildPrice * count_Child);
    totalPrice = (totalAudlt + totalChild);

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Adult'),
                    Text('THB ${widget.list[widget.index]['packPrice']}'),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
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
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("-"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5)),
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
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("+"),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Child'),
                    Text('THB ${widget.list[widget.index]['ticketKid']}'),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
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
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("-"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text("$count_Child"),
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
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("+"),
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
    );
  }
}

