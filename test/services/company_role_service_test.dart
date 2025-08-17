import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/company_role_service.dart';
import 'package:userverse_dart_client/src/utils/base_api.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([BaseApiService])
void main() {
  group('CompanyRoleService', () {
    late MockBaseApiService mockBaseApiService;
    late CompanyRoleService companyRoleService;

    setUp(() {
      mockBaseApiService = MockBaseApiService();
      companyRoleService = CompanyRoleService(mockBaseApiService);
    });

    test('getCompanyRoles success', () async {
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

      final roles = await companyRoleService.getCompanyRoles(
        companyId: 1,
      );

      expect(roles.records, isEmpty);
    });

    test('createRole success', () async {
      when(
        mockBaseApiService.post(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'name': 'Admin', 'description': 'admin role'},
        },
      );

      final role = await companyRoleService.createRole(
        companyId: 1,
        roleCreate: RoleCreate(name: 'Admin'),
      );

      expect(role.name, 'Admin');
    });
  });
}
