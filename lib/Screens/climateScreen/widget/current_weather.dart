import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/climateScreen/utils/custom_colors.dart';
import 'package:fluttertest/Screens/climateScreen/model/weather_data_current.dart';

class currentWeather extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const currentWeather({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //temp area
        tempAreaWidget(),
        const SizedBox( height: 20,),
        // show detail windspeed, humidity, clouds
        currentWeatherMoreDetailWidget(),
      ],
    );
  }

  Widget tempAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80.0,
          width: 80.0,
        ),
        Container(
          height: 50,
          width: 1,
          color: customColors.dividerLine,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${weatherDataCurrent.current.temp!.toInt()}°",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 68.0,
                fontFamily: 'Kanit',
                color: customColors.textColorBlack,
              )),
          TextSpan(
              text: "${weatherDataCurrent.current.weather![0].description}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                fontFamily: 'Kanit',
                color: Colors.grey,
              )),
        ])),
      ],
    );
  }

  Widget currentWeatherMoreDetailWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: customColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: customColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: customColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        const SizedBox(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text("${weatherDataCurrent.current.windSpeed}km/h",
              style: const TextStyle(fontFamily: 'Kanit', fontSize: 12.0,),
              textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text("${weatherDataCurrent.current.clouds}%",
              style: const TextStyle(fontFamily: 'Kanit', fontSize: 12.0,),
              textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text("${weatherDataCurrent.current.humidity}%",
              style: const TextStyle(fontFamily: 'Kanit', fontSize: 12.0,),
              textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
