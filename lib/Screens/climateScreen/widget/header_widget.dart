import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/global_controller.dart';

class headerWidget extends StatefulWidget {
  const headerWidget({super.key});

  @override
  State<headerWidget> createState() => _headerWidgetState();
}

class _headerWidgetState extends State<headerWidget> {
  String city = "";

  String date = DateFormat("yMMMMd").format(DateTime.now());
  

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLattitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  // parameters for the get address
  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    print(placemark);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: TextStyle(fontSize: 35.0, fontFamily: 'Kanit', height: 2.0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Kanit',
                color: Colors.grey[700],
                height: 1.5),
          ),
        ),
      ],
    );
  }
}
