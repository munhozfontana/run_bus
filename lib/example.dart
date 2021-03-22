import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Position position;
  List<Placemark> addresses;
  bool load = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        load = false;
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          load = false;
        });
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        setState(() {
          load = false;
        });
        return Future.error('Location permissions are denied');
      }
    }
    setState(() {
      load = true;
    });
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !load
            ? Text(
                "Latitude: ${position?.latitude} , Longitude: ${position?.longitude}, Andress: ${addresses?.first?.toJson()}",
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
      ),
    );
  }
}
