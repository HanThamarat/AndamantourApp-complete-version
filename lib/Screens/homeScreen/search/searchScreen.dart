import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Api/get_provice.dart';
import 'package:fluttertest/Screens/homeScreen/search/selectpackageProvices.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:fluttertest/models/selectProvice_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  var selectProvices;

  provices provices_api = provices();

  Future<List<DropDrown>> get_Provice() async {
    final response = await provices_api.selectProvice();

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) {
        final map = e as Map<String, dynamic>;
        return DropDrown(id: map['id'], nameEn: map['name_en']);
      }).toList();
    } else {
      print('res err');
    }
    throw Exception("Error fetch");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        elevation: 0.0,
        title: Text(
          "Search package",
          style: TextStyle(fontFamily: 'Kanit', color: GlobalColors.textColor),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: GlobalColors.textColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Column(
                      children: [
                        Text("เลือกจังหวัดที่ต้องการได้เลย", style: TextStyle(fontFamily: 'Kanit', fontSize: 16, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10,),
                        FutureBuilder<List<DropDrown>>(
                          future: get_Provice(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButtonFormField2(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  value: selectProvices,
                                  hint: Text("Select provices"),
                                  items: snapshot.data!.map((e) {
                                    return DropdownMenuItem(
                                        value: e.id, child: Text(e.nameEn.toString()));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectProvices = value;
                                      print(selectProvices);
                                    });
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                        SizedBox(height: 10,),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: GlobalColors.mainColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("Search",style: TextStyle(color: Colors.white, fontFamily: 'Kanit', fontWeight: FontWeight.w500),)),
                          ),
                          onTap: () async {
                            if (selectProvices != null) {
                              Navigator.of(context).push(
                                new CupertinoPageRoute(
                                    builder: (context) => new selectpackageProvice(proviceIDs: selectProvices,)),
                                );
                            } else {
                              setState(() {
                                 showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: "Please select provices.",
                                    ),
                                  );
                              });
                            }
                          },
                        )
                      ],
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class DropdownBtn extends StatefulWidget {
//   const DropdownBtn({super.key});

//   @override
//   State<DropdownBtn> createState() => _DropdownBtnState();
// }

// class _DropdownBtnState extends State<DropdownBtn> {
//   var selectProvices;

//   provices provices_api = provices();

//   Future<List<DropDrown>> get_Provice() async {
//     final response = await provices_api.selectProvice();

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body) as List;
//       return data.map((e) {
//         final map = e as Map<String, dynamic>;
//         return DropDrown(id: map['id'], nameEn: map['name_en']);
//       }).toList();
//     } else {
//       print('res err');
//     }
//     throw Exception("Error fetch");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<DropDrown>>(
//         future: get_Provice(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return DropdownButtonFormField2(
//                 isExpanded: true,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(vertical: 10),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                 ),
//                 dropdownStyleData: DropdownStyleData(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10)
//                   )
//                 ),
//                 value: selectProvices,
//                 hint: Text("Select provices"),
//                 items: snapshot.data!.map((e) {
//                   return DropdownMenuItem(
//                       value: e.id, child: Text(e.nameEn.toString()));
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectProvices = value;
//                     print(selectProvices);
//                   });
//                 });
//           } else {
//             return CircularProgressIndicator();
//           }
//         });
//   }
// }
