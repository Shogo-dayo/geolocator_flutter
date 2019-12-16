import 'package:flutter/material.dart';
import "dart:async";
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Geolocator',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: GeolocationExample(),
    );
  }
}

class GeolocationExample extends StatefulWidget {
  @override
  GeolocationExampleState createState() => new GeolocationExampleState();
}


class GeolocationExampleState extends State {

  Geolocator _geolocator;
  Position _position;

  @override
  void initState() {
    super.initState();


    _geolocator = Geolocator();

    void checkPermission() {
      _geolocator.checkGeolocationPermissionStatus().then((status) {
        print('status: $status');
      });
      _geolocator.checkGeolocationPermissionStatus(
          locationPermission: GeolocationPermission.locationAlways).then((
          status) {
        print('always status: $status');
      });
      _geolocator.checkGeolocationPermissionStatus(
          locationPermission: GeolocationPermission.locationWhenInUse)
        ..then((status) {
          print('whenInUse status: $status');
        });
    }


    LocationOptions locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high, distanceFilter: 1);

    checkPermission();
    //    updateLocation();

    StreamSubscription positionStream = _geolocator.getPositionStream(
        locationOptions).listen((Position position) {
      position = position;
    });

    void updateLocation() async {
      try {
        Position newPosition = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
            .timeout(new Duration(seconds: 5));

        setState(() {
          _position = newPosition;
        });
      } catch (e) {
        print('Error: ${e.toString()}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Geolocator example"),
      ),
      body: Center(
          child: Text(
              'Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
                  ' Longitude: ${_position != null ? _position.longitude.toString() : '0'}'
          )
      ),
    );
  }
}



