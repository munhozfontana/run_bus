import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';

class FindBusController extends ChangeNotifier {
  final CurrentLocationUserUseCase currentLocationUserUseCase;
  UserLocation userLocation;
  GoogleMapController googleMapController;

  FindBusController({@required this.currentLocationUserUseCase});

  onMapCreate(GoogleMapController controller) async {
    googleMapController = controller;
    googleMapController
        .setMapStyle(await rootBundle.loadString('assets/map_style.txt'));
    notifyListeners();
  }

  changeMap() async {
    var res = await currentLocationUserUseCase(Params());

    googleMapController.moveCamera(CameraUpdate.newLatLng(LatLng(
      res.getOrElse(() => null).location.latitude,
      res.getOrElse(() => null).location.longitude,
    )));
    notifyListeners();
  }

  navigatTo(lat, lng) async {
    googleMapController.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    notifyListeners();
  }

  void run() async {
    var res = await currentLocationUserUseCase(Params());
    res.fold((l) => null, (r) => userLocation = r);
    notifyListeners();
  }
}
