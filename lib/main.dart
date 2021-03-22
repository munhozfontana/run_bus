import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_bus/features/data/external/geocoding_adapter.dart';
import 'package:run_bus/features/data/external/location_adapter.dart';
import 'package:run_bus/features/data/repository/geocoding_repository.dart';
import 'package:run_bus/features/data/repository/location_repository.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';
import 'package:run_bus/features/presentation/find_bus_controller.dart';
import 'package:run_bus/features/presentation/find_bus_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => FindBusController(
          currentLocationUserUseCase: CurrentLocationUserUseCase(
            iGeocodingRepository: GeocodingRepository(
              iGeocodingAdapter: GeocodingAdapter(),
            ),
            iLocationRepository: LocationRepository(
              locationAdapter: LocationAdapter(),
            ),
          ),
        ),
        child: FindBusPage(),
      ),
    );
  }
}
