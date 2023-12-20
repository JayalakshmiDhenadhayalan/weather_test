import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherreportapp/controller/weathercontroller.dart';
TextEditingController _searchController=TextEditingController();
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationprovider = Provider.of<WeatherController>((context));
    final maxwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      
           TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter location name',
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
               locationprovider.clearSearch();
                },
              ),),),
               SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              locationprovider.checkLocationPermission();
            //  locationprovider.locationProvider();
              locationprovider.searchLocation(_searchController.text);
                locationprovider.weatherReport(locationprovider.lat, locationprovider.longt);

              //  if (locationprovider.hasPermission) {
              //     //  locationprovider.locationProvider();
              //       locationprovider.weatherReport(locationprovider.lat, locationprovider.longt);
              //     } else {
              //       print("location permission denied");
              //     }
            },
            child: Text('Search Location'),
          ),
            Text('The ${_searchController.text} Temperature is ${locationprovider.temp}'),
            Text('The Current Humidity is ${locationprovider.humidity}'),
            Text('The Current windspeed is ${locationprovider.windspeed}'),
            Text('The Current Condition is ${locationprovider.condition}'),
            // ElevatedButton(
            //     onPressed: () async {
            //       await locationprovider.checkLocationPermission();
            //       if (locationprovider.hasPermission) {
            //       //  locationprovider.locationProvider();
            //         locationprovider.weatherReport(locationprovider.lat, locationprovider.longt);
            //       } else {
            //         print("location permission denied");
            //       }
            //     },
            //     child: Text("Get current Location"))
          ],
        ),
      ),
    );
  }
}
