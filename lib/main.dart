import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:run_bus/features/data/external/apis/integration_area_api.dart';
import 'package:run_bus/features/data/external/apis/reference_api.dart';
import 'package:run_bus/features/data/external/apis/version_api.dart';
import 'package:run_bus/features/data/external/drivers/geocoding_adapter.dart';
import 'package:run_bus/features/data/external/drivers/http_adapter.dart';
import 'package:run_bus/features/data/external/drivers/location_adapter.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/data/repository/geocoding_repository_impl.dart';
import 'package:run_bus/features/data/repository/location_area_repository_impl.dart';
import 'package:run_bus/features/data/repository/location_repository_impl.dart';
import 'package:run_bus/features/data/repository/reference_repository_impl.dart';
import 'package:run_bus/features/data/repository/version_repository_impl.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';
import 'package:run_bus/features/domain/usecase/updade_data_on_init_use_case.dart';
import 'package:run_bus/features/presentation/find_bus_controller.dart';
import 'package:run_bus/features/presentation/find_bus_page.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var httpAdapterImpl = HttpAdapterImpl(
      client: http.Client(),
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
              iReferenceRepository: ReferenceRepository(
                iReferenceApi: ReferenceApi(
                  httpAdapter: httpAdapterImpl,
                ),
              ),
              iGeocodingRepository: GeocodingRepository(
                iGeocodingAdapter: GeocodingAdapter(),
              ),
              iLocationRepository: LocationRepository(
                locationAdapter: LocationAdapter(),
              ),
              iLocationAreaRepository: LocationAreaRepository(
                iLocationAreaApi: LocationAreaApi(
                  iHttp: httpAdapterImpl,
                ),
              ),
              iLocationVerifyAdapter: LocationVerifyAdapter(),
            ),
            updadeDataOnInitUseCase: UpdadeDataOnInitUseCase(
              iVersionDatabaseRepository: null,
              iVersionRepositoryApi: VersionRepository(
                iVersion: VersionApi(iHttp: httpAdapterImpl),
              ),
            ),
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
