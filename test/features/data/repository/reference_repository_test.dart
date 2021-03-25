import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/models/reference_model.dart';
import 'package:run_bus/features/data/repository/reference_repository.dart';

import 'reference_repository_test.mocks.dart';

@GenerateMocks([IReferenceApi])
void main() {
  ReferenceRepository referenceRepository;
  String tDistrict;
  ReferenceModel tResponse;
  MockIReferenceApi mockIReferenceApi;

  setUp(() {
    mockIReferenceApi = MockIReferenceApi();
    tResponse = ReferenceModel(
      descricao: 'any',
      sequencialRef: 1,
      tipo: 'any',
    );
    tDistrict = 'district';
    referenceRepository = ReferenceRepository(iReferenceApi: mockIReferenceApi);
  });
  test('Sould return Reference with no erros', () async {
    when(mockIReferenceApi.findReferenceByDistrict(any))
        .thenAnswer((_) async => tResponse);
    var res = await referenceRepository.findReferenceByDistrict(tDistrict);
    expect(res, isA<Right>());
  });

  test('Should Thows ApiExpetion when any erros', () async {
    when(mockIReferenceApi.findReferenceByDistrict(any))
        .thenThrow(ApiException());
    var res = await referenceRepository.findReferenceByDistrict(tDistrict);
    expect(res, isA<Left>());
  });
}
