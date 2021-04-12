import 'package:connectivity/connectivity.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_connectivity_adapter.dart';

class ConnectivityDriver implements IConnectivity {
  final Connectivity? connectivity;

  ConnectivityDriver({
    this.connectivity,
  });

  @override
  Future<bool> isConnected() async {
    try {
      var connectivityResult = await (connectivity!.checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw DriverException(error: e.toString());
    }
  }
}
