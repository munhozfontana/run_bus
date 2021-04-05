import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/entites/location_user.dart';
import 'package:run_bus/features/domain/usecase/location/current_location_user_use_case.dart';
import 'package:run_bus/features/domain/usecase/version/updade_data_use_case.dart';

class FindBusController extends ChangeNotifier {
  final CurrentLocationUserUseCase currentLocationUserUseCase;
  final UpdadeDataUseCase updadeDataOnInitUseCase;

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

  initData(BuildContext context) async {
    var res = await updadeDataOnInitUseCase(Params());
    res.fold(
      (l) => null,
      (right) {
        _snackShow(
          context,
          text: 'Versão atual $right',
          onPressed: () {
            print('Elo');
          },
        );
      },
    );
  }

  void _snackShow(
    BuildContext context, {
    text = 'Yay! A SnackBar!',
    label = 'Undo',
    onPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: label,
        onPressed: onPressed,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
