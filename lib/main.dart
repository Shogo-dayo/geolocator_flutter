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
  GeolocationExampleState createState() => GeolocationExampleState();
}


class GeolocationExampleState extends State<GeolocationExample> {

  Position position; // Geolocator

  @override
  void initState() {
    super.initState();
    _getLocation(context);
  }

  Future<void> _getLocation(context) async {
    Position _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high); // ここで精度を「high」に指定している
    print(_currentPosition);
    setState(() {
      position = _currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == GeolocationStatus.denied) {
            return Text(
              'Access to location denied',
              textAlign: TextAlign.center,
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Location Infomation",
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),

                Padding(
                    padding: EdgeInsets.all(10)
                ),

                Text("Your Current Location is :",
                  style: TextStyle(fontSize: 12)
                  ),

                Padding(
                    padding: EdgeInsets.all(20)
                ),

                Text("lat : ${position.latitude}",
                  style: TextStyle(fontSize: 15)
                ),

                Text("lng : ${position.longitude}",
                    style: TextStyle(fontSize: 15)
                ),
              ],
            ),
          );
        }
    );
  }
}



