import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:run_bus/features/presentation/find_bus_controller.dart';

class FindBusPage extends StatefulWidget {
  const FindBusPage({Key key}) : super(key: key);

  @override
  _FindBusPageState createState() => _FindBusPageState();
}

class _FindBusPageState extends State<FindBusPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FindBusController>(
        builder: (context, value, child) {
          return GoogleMap(
            onMapCreated: value.onMapCreate,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                37.42796133580664,
                -122.085749655962,
              ),
              zoom: 16,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<FindBusController>(context, listen: false)..changeMap();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
