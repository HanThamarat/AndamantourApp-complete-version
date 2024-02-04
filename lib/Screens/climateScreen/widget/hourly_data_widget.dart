import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/climateScreen/controller/global_controller.dart';
import 'package:fluttertest/Screens/climateScreen/model/weather_data_hourly.dart';
import 'package:fluttertest/Screens/climateScreen/utils/custom_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  //card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          alignment: Alignment.center,
          child: const Text(
            "Today",
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w400),
          ),
        ),
        HourlyList(),
      ],
    );
  }

  Widget HourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 110,
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0.5, 0),
                      blurRadius: 30,
                      spreadRadius: 1,
                      color: customColors.dividerLine.withAlpha(150),
                    ),
                  ],
                  gradient: cardIndex.value == index
                      ? const LinearGradient(colors: [
                          customColors.firstGradientColor,
                          customColors.secondGradientColor
                        ])
                      : null,
                ),
                child: HourlyDetail(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ))));
        },
      ),
    );
  }
}

//hourly details class
// ignore: must_be_immutable
class HourlyDetail extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  HourlyDetail(
      {super.key,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon,
      required this.index,
      required this.cardIndex,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Text(getTime(timeStamp), style: TextStyle(
            color: cardIndex == index ? Colors.white: customColors.textColorBlack,
            fontFamily: 'Kanit'
            ),),
        ),
        Container(
          margin: const EdgeInsets.all(5.0),
          child: Image.asset(
            "assets/weather/${weatherIcon}.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text("$temp°",style: TextStyle(
            color: cardIndex == index ? Colors.white: customColors.textColorBlack,
            fontFamily: 'Kanit'
            ),),
        ),
      ],
    );
  }
}
