import 'package:flutter/material.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';

class FindBusController extends ChangeNotifier {
  final CurrentLocationUserUseCase currentLocationUserUseCase;

  FindBusController({@required this.currentLocationUserUseCase});

  run() async {
    var res = await currentLocationUserUseCase(Params());
    res.fold((l) => null, (r) => print(r));
  }
}
