import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/position.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';

class FindBusController extends ChangeNotifier {
  final CurrentLocationUserUseCase currentLocationUserUseCase;
  UserLocation userLocation =
      UserLocation(district: "", location: Location(latitude: 0, longitude: 0));
  GoogleMapController googleMapController;
  Set<Polygon> list = Set<Polygon>();

  FindBusController({@required this.currentLocationUserUseCase});

  onMapCreate(GoogleMapController controller) async {
    googleMapController = controller;
    // googleMapController
    //     .setMapStyle(await rootBundle.loadString('assets/map_style.txt'));
    notifyListeners();
  }

  changeMap() async {
    var res = await currentLocationUserUseCase(Params());

    res.fold((l) => null, (r) {
      googleMapController.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(
            r.location.latitude,
            r.location.longitude,
          ),
        ),
      );
      userLocation = r;
      notifyListeners();
    });
  }

  teste() async {
    var lala = await currentLocationUserUseCase.teste();
    List colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.black,
      Colors.amber,
      Colors.blueAccent,
      Colors.purple,
      Colors.teal,
      Colors.deepPurple
    ];
    lala.fold(
      (l) => null,
      (r) {
        list = r
            .map(
              (e) => Polygon(
                polygonId: PolygonId(e.descricao),
                onTap: () => print(e),
                points: e.location
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ).copyWith(
                  strokeColorParam: colors[Random().nextInt(colors.length)]),
            )
            .toSet();

        notifyListeners();
      },
    );
  }
}
