import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:run_bus/features/data/external/http_adapter.dart';
import 'package:run_bus/features/presentation/find_bus_controller.dart';

class FindBusPage extends StatefulWidget {
  const FindBusPage({Key key}) : super(key: key);

  @override
  _FindBusPageState createState() => _FindBusPageState();
}

class _FindBusPageState extends State<FindBusPage> {
  Set<Polygon> listMarks = Set<Polygon>();

  @override
  void initState() {
    super.initState();
    var res = HttpAdapterImpl(client: http.Client()).getHttp(
        'https://www.sistemas.dftrans.df.gov.br/referencia/geojson/ra/21');

    res.then((value) {
      List<LatLng> list = value.body['geometry']['coordinates'].first.first
          .map<LatLng>((item) => LatLng(item[1], item[0]))
          .toList();

      Polygon listMark = Polygon(
        points: list,
        polygonId: PolygonId('1'),
      );
      listMarks.add(listMark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FindBusController>(
        builder: (context, value, child) {
          return GoogleMap(
            polygons: listMarks,
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
          Provider.of<FindBusController>(context, listen: false).changeMap();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
