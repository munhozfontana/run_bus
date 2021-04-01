import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/entites/location_user.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';
import 'package:run_bus/features/domain/usecase/updade_data_on_init_use_case.dart';

class FindBusController extends ChangeNotifier {
  final CurrentLocationUserUseCase currentLocationUserUseCase;
  final UpdadeDataOnInitUseCase updadeDataOnInitUseCase;

  UserLocation userLocation =
      UserLocation(district: "", location: Location(latitude: 0, longitude: 0));
  late GoogleMapController googleMapController;
  Set<Polygon> list = Set<Polygon>();

  FindBusController(
      {required this.currentLocationUserUseCase,
      required this.updadeDataOnInitUseCase});

  onMapCreate(GoogleMapController controller) async {
    googleMapController = controller;
    // googleMapController
    //     .setMapStyle(await rootBundle.loadString('assets/map_style.txt'));
    notifyListeners();
  }

  changeMap() async {
    var res = await (currentLocationUserUseCase(Params())
        as FutureOr<Either<Failure, UserLocation>>);

    res.fold((l) => null, (r) {
      googleMapController.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(
            r.location!.latitude!,
            r.location!.longitude!,
          ),
        ),
      );
      userLocation = r;
      notifyListeners();
    });
  }

  initData() {
    updadeDataOnInitUseCase(Params());
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
                polygonId: PolygonId(e.descricao!),
                onTap: () => print(e),
                points: e.location!
                    .map((e) => LatLng(e.latitude!, e.longitude!))
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
