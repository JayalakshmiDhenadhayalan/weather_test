import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;




class WeatherController extends ChangeNotifier {
  double lat = 0.0;
  double longt = 0.0;
  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;
  double temp = 0.0;
  String condition = '';
  num humidity=0; 
  double windspeed=0.0;
  String searchQuery='';

  // locationProvider() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );

  //     lat = position.latitude;
  //     longt = position.longitude;
  //     notifyListeners();
  //   } catch (e) {
  //     print("error getting location $e");
  //   }
  // }

  weatherReport(double latittude, double longtitude) async {
    final url =
        'http://api.weatherapi.com/v1/current.json?key=48cb8edaa7624494b5f130621232410&q=$lat,$longt';
    print(url);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //  final weatherModel = weatherModelFromJson(response.body);
      final weatherData = json.decode(response.body);
      final currentCondition = weatherData['current'];
      temp = currentCondition['temp_c'];
      condition = currentCondition['condition']['text'];
      humidity= currentCondition['humidity'];
      windspeed=currentCondition['wind_kph'];
      print('$temp,$condition');
      notifyListeners();
    } else {
      print("Is Error ${response.statusCode}");
      notifyListeners();
    }
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _hasPermission = false;
      } else {
        _hasPermission = true;
      }
    } else {
      _hasPermission = true;
    }
    notifyListeners();
  }

  searchLocation(String searchValue) async {
    print("The Search value is $searchValue");

    try {
      List<Location> locations = await locationFromAddress(searchValue);
      print('_______$locations');

      if (locations.isNotEmpty) {
        lat = locations.first.latitude;
        longt = locations.first.longitude;
        print("++++++++++++++++++$lat,$longt");
        searchQuery=searchValue;
        notifyListeners();
      } else {
        print('Location not found');
        notifyListeners();
      }
    } catch (e) {

      print("Error  $e");
    }
  }

  clearSearch(){
    searchQuery='';
    notifyListeners();
  }
}
