import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/climateScreen/utils/custom_colors.dart';
import 'package:fluttertest/Screens/climateScreen/widget/current_weather.dart';
import 'package:fluttertest/Screens/climateScreen/widget/daily_data_focus.dart';
import 'package:fluttertest/Screens/climateScreen/widget/header_widget.dart';
import 'package:fluttertest/Screens/climateScreen/controller/global_controller.dart';
import 'package:fluttertest/Screens/climateScreen/widget/hourly_data_widget.dart';
import 'package:get/get.dart';

class climateScreen extends StatefulWidget {
  const climateScreen({super.key});

  @override
  State<climateScreen> createState() => _climateScreenState();
}

class _climateScreenState extends State<climateScreen> {
  //call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Climate",style: TextStyle(fontFamily: 'Kanit', color: customColors.textColorBlack, fontWeight: FontWeight.w500),),
        leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: customColors.firstGradientColor,
            )),
      ),
      body: SafeArea(
        child: Obx(() => globalController.checkLonding().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 0.0,
                    ),
                    const headerWidget(),
                    //current temp
                    currentWeather(
                      weatherDataCurrent:
                          globalController.getWeatherData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeather()),
                    DailyDataFocus(
                      weatherDataDaily:
                          globalController.getWeatherData().getDailyWeather(),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
