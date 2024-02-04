import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertest/Api/selectReview.dart';
import 'package:fluttertest/Screens/packageScreen/packages_detail.dart';
import 'package:fluttertest/domain.dart';
import 'package:fluttertest/globalColor/global_Color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class notificationScreen extends StatefulWidget {
  const notificationScreen({super.key});
  static const String routeName = '/notifications';

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Review", style: TextStyle(fontFamily: 'Kanit'),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: selectReview(),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class selectReview extends StatefulWidget {
  const selectReview({super.key});

  @override
  State<selectReview> createState() => _selectReviewState();
}

class _selectReviewState extends State<selectReview> {

  selectReviewApis select_Review = selectReviewApis();

  Future selectReviews() async {
    final response = await select_Review.selectReview_Apis();

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      final resData = data['body'];
      return resData;
    } else {
      print('select data err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectReviews(), 
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
              final int rateting = int.parse(list.elementAt(index)['stars']);
              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${Mydomain.testNode}/userImage/${list.elementAt(index)['user_image']}"),
                                        ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("${list.elementAt(index)['nameConcat']}"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            starRate(rateting.toDouble()),
                                            SizedBox(width: 5,),
                                            Text(DateFormat.yMMMd().format(DateTime.parse(list.elementAt(index)['review_date'])), style: TextStyle(fontFamily: 'Kanit', color: Colors.grey.shade600, fontSize: 12),),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: GlobalColors.mainColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("${list.elementAt(index)['comDeteil']}", style: TextStyle(fontFamily: 'Kanit'),),
                              ),
                              SizedBox(height: 10,),
                              list.elementAt(index)['image_review'] != null 
                              ? Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("${Mydomain.testNode}/imageReview/${list.elementAt(index)['image_review']}",),
                                    )
                                ),
                              ) : Container(),
                              SizedBox(height: 10,),
                              GestureDetector(
                                child: Container(
                                  color: GlobalColors.mainColor.withOpacity(0.0),
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.personWalkingLuggage, color: GlobalColors.mainColor,),
                                          SizedBox(width: 10,),
                                          Text("${list.elementAt(index)['packName']}", style: TextStyle(fontFamily: 'Kanit'),)
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios_rounded)
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  //  Navigator.of(context).push(
                                  //   new CupertinoPageRoute(
                                  //       builder: (context) => new packagesDetail(list: list, index: index,)),
                                  // );
                                   Navigator.of(context).push(_createRoute(list: list, index: index));
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            ),
        ) : Container(
          child: Text("not data"),
        );
      }
      );
  }

    starRate(_rateting) {
    return RatingBarIndicator(
        rating: _rateting,
        itemBuilder: (context, index) => Icon(
             Icons.star,
            color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 15,
        direction: Axis.horizontal,
    );
  }
}


//custom pageAnimation
Route _createRoute({required List list, required int index}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => new packagesDetail(list: list, index: index),
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