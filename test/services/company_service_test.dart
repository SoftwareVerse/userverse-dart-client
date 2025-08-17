import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/company_service.dart';
import 'package:userverse_dart_client/src/utils/base_api.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([BaseApiService])
void main() {
  group('CompanyService', () {
    late MockBaseApiService mockBaseApiService;
    late CompanyService companyService;

    setUp(() {
      mockBaseApiService = MockBaseApiService();
      companyService = CompanyService(mockBaseApiService);
    });

    test('createCompany success', () async {
      when(
        mockBaseApiService.post(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'company@test.com'},
        },
      );

      final company = await companyService.createCompany(
        companyCreate: CompanyCreate(email: 'company@test.com'),
      );

      expect(company.id, 1);
    });

    test('getCompany success', () async {
      when(
        mockBaseApiService.get(
          any,
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'company@test.com'},
        },
      );

      final company = await companyService.getCompany(
        companyId: 1,
      );

      expect(company.id, 1);
    });

    test('updateCompany success', () async {
      when(
        mockBaseApiService.patch(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'company@test.com'},
        },
      );

      final company = await companyService.updateCompany(
        companyId: 1,
        companyUpdate: CompanyUpdate(),
      );

      expect(company.id, 1);
    });
  });
}
