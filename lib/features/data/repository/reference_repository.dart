import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/http_adapter.dart';
import 'package:run_bus/features/data/models/reference_model.dart';
import 'package:run_bus/features/domain/entites/reference.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';

class ReferenceRepository implements IReferenceRepository {
  final IReferenceApi iReferenceApi;

  ReferenceRepository({@required this.iReferenceApi});

  @override
  Future<Either<Failure, Reference>> findReferenceByDistrict(
      String district) async {
    try {
      return Right(await iReferenceApi.findReferenceByDistrict(district));
    } on ApiException catch (e) {
      return Left(ServerFailure(detail: e.error));
    }
  }
}

abstract class IReferenceApi {
  Future<ReferenceModel> findReferenceByDistrict(String district);
}

class ReferenceApi implements IReferenceApi {
  final HttpAdapter httpAdapter;
  ReferenceApi({
    @required this.httpAdapter,
  });

  @override
  Future<ReferenceModel> findReferenceByDistrict(String district) async {
    var res = await httpAdapter.getHttp(
        'https://www.sistemas.dftrans.df.gov.br/referencia/find/RA : $district');
    if (res.body.first != null) {
      return ReferenceModel.fromMap(res.body.first);
    }
    return ReferenceModel(descricao: null, sequencialRef: null, tipo: null);
  }
}
