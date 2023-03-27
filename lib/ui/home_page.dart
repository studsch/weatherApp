import 'dart:convert';
import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather/components/weather_item.dart';

import 'package:weather/constants.dart';
import 'package:weather/ui/login_page.dart';
import 'package:weather/ui/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();

  void signUserOut() {
    // FirebaseAuth.instance.signOut();
  }

  // ignore: non_constant_identifier_names
  // static String API_KEY = "e5affb344f9e4069a81150751232203";

  String location = "Krasnoyarsk";
  String weatherIcon = "heavycloudy.png";
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = "";

  List hourlyWeatherForecast = [
    {
      "time_epoch": "1679850000",
      "time": "2023-03-27 00:00",
      "temp_c": 4.3,
      "temp_f": "39.7",
      "is_day": "0",
      "condition": {
        "text": "Partly cloudy",
      }
    }
  ];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = "";

  // String searchWeatherAPI =
  //     "https://api.weatherapi.com/v1/forecast.json?key=$API_KEY&days=7&q=";

  // void fetchWeatherData(String searchText) async {
  //   try {
  //     var searchResult =
  //         await http.get(Uri.parse(searchWeatherAPI + searchText));

  //     final weatherData = Map<String, dynamic>.from(
  //         json.decode(searchResult.body) ?? "No data");

  //     var locationData = weatherData["location"];
  //     var currentWeather = weatherData["current"];
  //     setState(() {
  //       location = getShortLocationName(locationData["name"]);

  //       var parsedDate =
  //           DateTime.parse(locationData["localtime"].substring(0, 10));
  //       var newDate = DateFormat("MMMMEEEEd").format(parsedDate);
  //       currentDate = newDate;

  //       currentWeatherStatus = currentWeather["condition"]["text"];
  //       weatherIcon =
  //           "${currentWeatherStatus.replaceAll(" ", "").toLowerCase()}.png";
  //       temperature = currentWeather["temp_c"].toInt();
  //       windSpeed = currentWeather["wind_kph"].toInt();
  //       humidity = currentWeather["humidity"].toInt();
  //       cloud = currentWeather["cloud"].toInt();

  //       dailyWeatherForecast = weatherData["forecast"]["forecastday"];
  //       hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
  //       // print(dailyWeatherForecast);
  //     });
  //   } catch (e) {
  //     //
  //   }
  // }

  // static String getShortLocationName(String s) {
  //   List<String> wordList = s.split(" ");

  //   if (wordList.isNotEmpty) {
  //     if (wordList.length > 1) {
  //       return "${wordList[0]} ${wordList[1]}";
  //     } else {
  //       return wordList[0];
  //     }
  //   } else {
  //     return " ";
  //   }
  // }

  @override
  void initState() {
    // fetchWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        color: _constants.primaryColor.withOpacity(.1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * .7,
                decoration: BoxDecoration(
                  gradient: _constants.linearGradientBlue,
                  boxShadow: [
                    BoxShadow(
                      color: _constants.primaryColor.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MapPage())),
                          icon: const Icon(
                            IconData(0xf1ae, fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/pin.png", width: 20),
                            const SizedBox(width: 2),
                            Text(
                              location,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                            IconButton(
                              onPressed: () {
                                _cityController.clear();
                                showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                          controller:
                                              ModalScrollController.of(context),
                                          child: Container(
                                            height: size.height * .2,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  child: Divider(
                                                    thickness: 3.5,
                                                    color:
                                                        _constants.primaryColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  onChanged: (searchText) {
                                                    // fetchWeatherData(
                                                    //     searchText);
                                                  },
                                                  controller: _cityController,
                                                  autofocus: true,
                                                  decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        color: _constants
                                                            .primaryColor,
                                                      ),
                                                      suffixIcon:
                                                          GestureDetector(
                                                        onTap: () =>
                                                            _cityController
                                                                .clear(),
                                                        child: Icon(Icons.close,
                                                            color: _constants
                                                                .primaryColor),
                                                      ),
                                                      hintText: "Search city",
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: _constants
                                                              .primaryColor,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // нужна иконочка котика?
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image.asset(
                        //     // profile image
                        //     "assets/cat.jpg",
                        //     width: 40,
                        //     height: 40,
                        //   ),
                        // ),
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          ),
                          icon: const Icon(Icons.logout),
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: Image.asset("assets/$weatherIcon"),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            // temperature.toString(),
                            "8",
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader,
                            ),
                          ),
                        ),
                        Text(
                          "o",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constants.shader,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      // currentWeatherStatus,
                      "Partly cloud",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      // currentDate,
                      "Thursday, March 30",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider(
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                            // value: windSpeed.toInt(),
                            value: 34,
                            unit: "km/h",
                            imageUrl: "assets/windspeed.png",
                          ),
                          WeatherItem(
                            // value: humidity.toInt(),
                            value: 57,
                            unit: "%",
                            imageUrl: "assets/humidity.png",
                          ),
                          WeatherItem(
                            // value: cloud.toInt(),
                            value: 50,
                            unit: "%",
                            imageUrl: "assets/cloud.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: size.height * .20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Today",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        itemCount: hourlyWeatherForecast.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String currenttime =
                              DateFormat("HH:mm:ss").format(DateTime.now());
                          String currentHour = currenttime.substring(0, 2);

                          // print(hourlyWeatherForecast);
                          // print(index);
                          String forecastTime = hourlyWeatherForecast[index]
                                  ["time"]
                              .substring(11, 16);
                          String forecastHour = hourlyWeatherForecast[index]
                                  ["time"]
                              .substring(11, 13);

                          String forecastWeatherName =
                              hourlyWeatherForecast[index]["condition"]["text"];
                          String forecastWeatherIcon =
                              "${forecastWeatherName.replaceAll(" ", "").toLowerCase()}.png";

                          String forecastTemperatur =
                              hourlyWeatherForecast[index]["temp_c"]
                                  .round()
                                  .toString();

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            margin: const EdgeInsets.only(right: 20),
                            width: 65,
                            decoration: BoxDecoration(
                                color: currentHour == forecastHour
                                    ? Colors.white
                                    : _constants.primaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color:
                                        _constants.primaryColor.withOpacity(.2),
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  forecastTime,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: _constants.greyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Image.asset(
                                  "assets/$weatherIcon",
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "4",
                                      style: TextStyle(
                                        color: _constants.greyColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "o",
                                      style: TextStyle(
                                        color: _constants.greyColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        fontFeatures: const [
                                          FontFeature.enable("sups"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
