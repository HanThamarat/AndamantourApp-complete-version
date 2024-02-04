import 'dart:convert';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttertest/Api/promotionApi.dart';
import 'package:fluttertest/Screens/climateScreen/climateScreen.dart';
import 'package:fluttertest/Screens/packageScreen/packages_detail.dart';
import 'package:fluttertest/assets/theme/constants/colors.dart';
import 'package:fluttertest/assets/theme/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/Screen.dart';
import 'package:fluttertest/Screens/homeScreen/search/searchScreen.dart';
import 'package:fluttertest/domain.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../globalColor/global_Color.dart';

class homeScreens extends StatefulWidget {
  final String? userID;
  final String? firstName;
  final String? lastName;

  const homeScreens(
      {super.key,
      required this.userID,
      required this.firstName,
      required this.lastName});

  static const String routeName = "/feed";
  @override
  State<homeScreens> createState() => _homeScreensState();
}

class _homeScreensState extends State<homeScreens> {
  late final PageController pageController;
  int pageNo = 0;

  late final Timer carsoueItem;

  // Timer getTimer() {
  //   return Timer.periodic(const Duration(seconds: 3), (timer) {
  //     if (pageNo == 5) {
  //       pageNo = 0;
  //     }
  //     pageController.animateToPage(
  //       pageNo,
  //       duration: const Duration(seconds: 1),
  //       curve: Curves.easeInCirc,
  //     );
  //     pageNo++;
  //   });
  // }

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    // carsoueItem = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 48.0, left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 33.0,
                            child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: searchScreen(),
                                          type: PageTransitionType.fade));
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    // ignore: deprecated_member_use
                                    primary: Colors.white,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              'ค้นหาแพ็คทัวร์ได้ที่นี้',
                                              textStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Kanit',
                                                  fontSize: 13.0),
                                              speed: const Duration(
                                                  milliseconds: 200),
                                            ),
                                            TyperAnimatedText(
                                              'เกาะพีพี',
                                              textStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Kanit',
                                                  fontSize: 13.0),
                                              speed: const Duration(
                                                  milliseconds: 200),
                                            ),
                                            TyperAnimatedText(
                                              '4 เกาะ',
                                              textStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Kanit',
                                                  fontSize: 13.0),
                                              speed: const Duration(
                                                  milliseconds: 200),
                                            ),
                                          ],
                                          totalRepeatCount: 4,
                                          pause: const Duration(
                                              milliseconds: 5000),
                                          displayFullTextOnTap: true,
                                          stopPauseOnTap: true,
                                        )),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: TColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 47.0, top: 26.0, right: 47.0),
                                child: SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // button 1
                                      Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 65.0,
                                              width: 65.0,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          child: saleScreen(),
                                                          type:
                                                              PageTransitionType
                                                                  .fade));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        HexColor("#3277C7"),
                                                    elevation: 0.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                child: Image.asset(
                                                    'assets/sale.png'),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6.0)),
                                            ),
                                            Text(
                                              "ลดราคาตอนนี้",
                                              style: TextStyle(
                                                  fontFamily: 'Kanit'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //button 2
                                      Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 65.0,
                                              width: 65.0,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          child:
                                                              climateScreen(),
                                                          type:
                                                              PageTransitionType
                                                                  .fade));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        GlobalColors.mainColor,
                                                    elevation: 0.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0))),
                                                child: Image.asset(
                                                  'assets/climate.png',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6.0)),
                                            ),
                                            Text(
                                              "สภาพอากาศ",
                                              style: TextStyle(
                                                  fontFamily: 'Kanit'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // line
                              Padding(
                                padding: const EdgeInsets.only(top: 26.0),
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

                              // silde box
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      child: PageView.builder(
                                        controller: pageController,
                                        onPageChanged: (index) {
                                          pageNo = index;
                                          setState(() {});
                                        },
                                        itemBuilder: (_, index) {
                                          return AnimatedBuilder(
                                            animation: pageController,
                                            builder: (ctx, child) {
                                              return child!;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 16.0, right: 16.0),
                                              height: 200,
                                              decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "lib/img/tour1.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: GlobalColors.mainColor,
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: 5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        5,
                                        (index) => Container(
                                          margin: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          width: pageNo == index ? 22.0 : 8.0,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                              color: pageNo == index
                                                  ? GlobalColors.mainColor
                                                  : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.directions_boat_rounded),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "แพ็คเกจทัวร์ตอนนี้",
                                            style: TextStyle(
                                                fontFamily: "Kanit",
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: selectPackage(
                                        userID: widget.userID,
                                        firstName: widget.firstName,
                                        lastName: widget.lastName,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100.0,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
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

//package card
class selectPackage extends StatefulWidget {
  final String? userID;
  final String? firstName;
  final String? lastName;

  const selectPackage({
    super.key,
    required this.userID,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<selectPackage> createState() => _selectPackageState();
}

class _selectPackageState extends State<selectPackage> {
  bool IscheckPrice = true;
  bool IscheckPro = true;

  @override
  void initState() {
    super.initState();
    selectPackages();
  }

  promotions pro = promotions();

  //function selectpackage
  Future selectPackages() async {
    String url = "${Mydomain.testNode}/ApiRouters/selectpackages";
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      // return json.decode(response.body);
      var data = json.decode(response.body);
      //check response data
      return data;
    } else {
      // show alert
      setState(() {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Something went wronggggggg.",
          ),
        );
      });
    }
  }

  Future checkPrice(packPrice) async {
    if (packPrice == null) {
      IscheckPrice = true;
    } else {
      IscheckPrice = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectPackages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Container(
                child: new GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 250.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    checkPrice(list.elementAt(index)['packPrice']);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(_createRoute(list: list, index: index)),
                        // Navigator.of(context).push(
                        //   new MaterialPageRoute(
                        //     builder: (context) => new packagesDetail(
                        //       list: list,
                        //       index: index,
                        //     ),
                        //   ),
                        // ),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              child: Image.network(
                                "${Mydomain.Selectdomain}/Admin/agents/insertpackage/pack_img/${list.elementAt(index)['image']}",
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 5.0),
                                    child: Text(
                                      "${list.elementAt(index)['packName']}",
                                      style: TextStyle(
                                          fontFamily: "Kanit",
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 5.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Start',
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontSize: 11),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            child: IscheckPrice
                                                ? Text(
                                                    "THB ${list.elementAt(index)['priceCharter']}",
                                                    style: TextStyle(
                                                      fontFamily: "Kanit",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                : Text(
                                                    "THB ${list.elementAt(index)['packPrice']}",
                                                    style: TextStyle(
                                                      fontFamily: "Kanit",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      loading(),
                      SizedBox(
                        height: 10,
                      ),
                      loading(),
                      SizedBox(
                        height: 10,
                      ),
                      loading(),
                      SizedBox(
                        height: 10,
                      ),
                      loading(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.withOpacity(0.5),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    textloading(
                      width: 100,
                      height: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    textloading(
                      width: 50,
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    textloading(
                      width: 250,
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    textloading(
                      width: 250,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//custom pageAnimation
Route _createRoute({required List list, required int index}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        new packagesDetail(list: list, index: index),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class textloading extends StatelessWidget {
  textloading({
    super.key,
    required this.height,
    required this.width,
  });

  double? height, width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.withOpacity(0.5),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black),
        ),
      ),
    );
  }
}
