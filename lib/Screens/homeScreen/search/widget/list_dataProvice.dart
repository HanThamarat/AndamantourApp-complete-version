import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/selectpackProvice.dart';
import 'package:fluttertest/Screens/packageScreen/packages_detail.dart';
import 'package:fluttertest/domain.dart';

class listdataPackprovice extends StatefulWidget {
  int proviceIDs;
  
  listdataPackprovice({
    super.key,
    required this.proviceIDs
    });

  @override
  State<listdataPackprovice> createState() => _listdataPackproviceState();
}

class _listdataPackproviceState extends State<listdataPackprovice> {
  bool IscheckPro = true;

  String proviceName = '';

  selectpackProvices selectpack_Provices = selectpackProvices();

  @override
  void initState() {
    super.initState();
    selectpackProvices_Api();
  }

  Future selectpackProvices_Api() async {
    var response = await selectpack_Provices.selectpackProvicesApi(widget.proviceIDs);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      proviceName = data[0]['name_en'];
      print(proviceName);
      return data;
    } else {
      print('server err');
    }
  }

  Future checkpacktype(packCheck) async {
    if (packCheck == null) {
      IscheckPro = true;
    } else {
      IscheckPro = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectpackProvices_Api(), 
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData 
        ? Scaffold(
          appBar: AppBar(
            title: Text("Pakage in $proviceName"),
            centerTitle: true,
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: new ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                      List list = snapshot.data;
                      checkpacktype(list.elementAt(index)['packPrice']);
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
                                            Text("THB ${list.elementAt(index)['priceCharter']}", style: TextStyle(fontFamily: 'Kanit', fontSize: 14),),
                                          ],
                                        ),
                                      ) : Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("THB ${list.elementAt(index)['packPrice']}", style: TextStyle(fontFamily: 'Kanit', fontSize: 14),),
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
              ),
            ),
          ),
        ) : 
        Container(
          child: Text(''),
        );
        }
      );
  }
}