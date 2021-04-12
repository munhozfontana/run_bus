import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:run_bus/features/data/external/apis/integration_area_api.dart';
import 'package:run_bus/features/data/external/apis/place_api.dart';
import 'package:run_bus/features/data/external/apis/reference_api.dart';
import 'package:run_bus/features/data/external/apis/version_api.dart';
import 'package:run_bus/features/data/external/databases/floor_database_config/app_database.dart';
import 'package:run_bus/features/data/external/databases/version_database.dart';
import 'package:run_bus/features/data/external/drivers/geocoding_adapter.dart';
import 'package:run_bus/features/data/external/drivers/http_adapter.dart';
import 'package:run_bus/features/data/external/drivers/location_adapter.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/data/repository/geocoding_repository_impl.dart';
import 'package:run_bus/features/data/repository/location_area_repository_impl.dart';
import 'package:run_bus/features/data/repository/location_repository_impl.dart';
import 'package:run_bus/features/data/repository/place_repository.dart';
import 'package:run_bus/features/data/repository/reference_repository_impl.dart';
import 'package:run_bus/features/data/repository/utils_repository_impl.dart';
import 'package:run_bus/features/data/repository/version_repository_impl.dart';
import 'package:run_bus/features/domain/usecase/location/current_location_user_use_case.dart';
import 'package:run_bus/features/domain/usecase/version/updade_data_use_case.dart';
import 'package:run_bus/features/presentation/find_bus_controller.dart';
import 'package:run_bus/features/presentation/find_bus_page.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp()
    ..db = await $FloorAppDatabase.databaseBuilder('app_database.db').build());
}

class MyApp extends StatelessWidget {
  late final AppDatabase? db;

  @override
  Widget build(BuildContext context) {
    var utilsRepositoryImpl = UtilsRepositoryImpl();

    var httpAdapterImpl = HttpAdapterImpl(
      client: http.Client(),
    );

    // REPOSITORIES
    var versionRepository = VersionRepository(
      api: VersionApi(iHttp: httpAdapterImpl),
      db: VersionDatabase(db: db),
      utilsRepository: utilsRepositoryImpl,
    );

    var referenceRepository = ReferenceRepository(
      api: ReferenceApi(iHttp: httpAdapterImpl),
      db: null,
      utilsRepository: null,
    );

    var locationAreaRepository = LocationAreaRepository(
      api: LocationAreaApi(iHttp: httpAdapterImpl),
      db: null,
      utilsRepository: null,
    );

    var placeRepository = PlaceRepository(
      api: PlaceApi(iHttp: httpAdapterImpl),
    );

    var geocodingRepository = GeocodingRepository(
      driver: GeocodingAdapter(
        geocodingAdapterHelper: GeocodingAdapterHelper(),
      ),
    );

    var locationRepository = LocationRepository(
      driver: LocationAdapter(),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) {
          return FindBusController(
            currentLocationUserUseCase: CurrentLocationUserUseCase(
              iReferenceRepository: referenceRepository,
              iLocationAreaRepository: locationAreaRepository,
              iGeocodingRepository: geocodingRepository,
              iLocationRepository: locationRepository,
              driver: LocationVerifyAdapter(),
            ),
            updadeDataOnInitUseCase: UpdadeDataUseCase(
              iVersionRepository: versionRepository,
              iPlacesRepository: placeRepository,
            ),
            // updadeDataOnInitUseCase: UpdadeDataUseCase(
            // ),
          );
        },
        child: FindBusPage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
