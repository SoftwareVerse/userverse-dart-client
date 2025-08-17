import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/company_user_service.dart';
import 'package:userverse_dart_client/src/utils/base_api.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([BaseApiService])
void main() {
  group('CompanyUserService', () {
    late MockBaseApiService mockBaseApiService;
    late CompanyUserService companyUserService;

    setUp(() {
      mockBaseApiService = MockBaseApiService();
      companyUserService = CompanyUserService(mockBaseApiService);
    });

    test('getCompanyUsers success', () async {
      when(
        mockBaseApiService.get(
          any,
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {
            'records': [],
            'pagination': {
              'total_records': 0,
              'limit': 10,
              'page': 1,
              'total_pages': 0
            }
          },
        },
      );

      final users = await companyUserService.getCompanyUsers(
        companyId: 1,
      );

      expect(users.records, isEmpty);
    });

    test('addUserToCompany success', () async {
      when(
        mockBaseApiService.post(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'user@test.com', 'role_name': 'Viewer'},
        },
      );

      final user = await companyUserService.addUserToCompany(
        companyId: 1,
        companyUserAdd: CompanyUserAdd(email: 'user@test.com'),
      );

      expect(user.id, 1);
    });
  });
}
