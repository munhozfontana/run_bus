import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/models/version_model.dart';

class VersionApi implements IVersion {
  final IHttp? iHttp;

  VersionApi({
    required this.iHttp,
  });

  @override
  Future<VersionModel?> lastVersion() async {
    try {
      var res = await iHttp!
          .getHttp('https://www.sistemas.dftrans.df.gov.br/carga/ultima');
      return VersionModel.fromJson(res.body!);
    } catch (e) {
      throw ApiException();
    }
  }

  @override
  Future<void> saveVersion(int? version) {
    throw ApiNotExists();
  }
}
