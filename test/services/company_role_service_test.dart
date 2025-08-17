import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/company_role_service.dart';


@GenerateMocks([http.Client])
void main() {
  group('CompanyRoleService', () {
    late http.Client client;
    late CompanyRoleService companyRoleService;

    setUp(() {
      client = MockClient();
      companyRoleService =
          CompanyRoleService(client: client, baseUrl: 'https://api.test');
    });

    test('getCompanyRoles success', () async {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"records": [], "pagination": {"total_records": 0, "limit": 10, "page": 1, "total_pages": 0}}}',
          200,
        ),
      );

      final roles = await companyRoleService.getCompanyRoles(
        token: 'abc',
        companyId: 1,
      );

      expect(roles.records, isEmpty);
    });

    test('createRole success', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"name": "Admin", "description": "admin role"}}',
          201,
        ),
      );

      final role = await companyRoleService.createRole(
        token: 'abc',
        companyId: 1,
        roleCreate: RoleCreate(name: 'Admin'),
      );

      expect(role.name, 'Admin');
    });
  });
}
