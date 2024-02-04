import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/packageSale.dart';
import 'package:fluttertest/Screens/packageScreen/packages_detail.dart';
import 'package:fluttertest/domain.dart';

class selectPackageSale extends StatefulWidget {
  const selectPackageSale({super.key});

  @override
  State<selectPackageSale> createState() => _selectPackageSaleState();
}

class _selectPackageSaleState extends State<selectPackageSale> {
  bool IscheckPro = true;

  packSale packsale = packSale();

  @override
  void initState() {
    super.initState();
    selectpackSale();
  }

  Future selectpackSale() async {
    var response = await packsale.packsaleApi();

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      print('server err');
    }
  }

  Future checkpacktype(packCheck) async {
    if (packCheck != null) {
      IscheckPro = true;
    } else {
      IscheckPro = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectpackSale(), 
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
                checkpacktype(list.elementAt(index)['promotionPrice_charterBoat']);
                return GestureDetector(
                  onTap: () {
                  Navigator.of(context).push(
                    new CupertinoPageRoute(
                        builder: (context) => new packagesDetail(
                          list: list,
                          index: index,
                        )),
                    );
                  },
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 0.0,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${list.elementAt(index)['image']}"),
                                      )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("${list.elementAt(index)['packName']}", style: TextStyle(fontFamily: 'Kanit', fontSize: 16, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 20,),
                                    SizedBox(width: 5,),
                                    Text("${list.elementAt(index)['name_en']}")
                                  ],
                                ),
                                SizedBox(height: 10,),
                                IscheckPro ? Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("THB ${list.elementAt(index)['priceCharter']}", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontFamily: 'Kanit', fontSize: 12),),
                                      SizedBox(width: 5,),
                                      Text("THB ${list.elementAt(index)['promotionPrice_charterBoat']}", style: TextStyle(fontFamily: 'Kanit'),),
                                    ],
                                  ),
                                ) : Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("THB ${list.elementAt(index)['packPrice']}", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontFamily: 'Kanit', fontSize: 12),),
                                      SizedBox(width: 5,),
                                      Text("THB ${list.elementAt(index)['promotionPrice_Adult']}", style: TextStyle(fontFamily: 'Kanit'),),
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
                );
              }
            ),
        ) : 
        Container(
          child: Text('server err'),
        );
        }
      );
  }
}
