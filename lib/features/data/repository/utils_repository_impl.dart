import 'package:run_bus/features/data/external/adapters/abs_connectivity_adapter.dart';

class UtilsRepositoryImpl {
  final IConnectivity? iConnectivity;

  UtilsRepositoryImpl({
    this.iConnectivity,
  });

  Future<bool> internetCheck() async {
    bool isConnect;
    try {
      isConnect = await iConnectivity!.isConnected();
    } catch (e) {
      isConnect = false;
    }
    return isConnect;
  }
}
