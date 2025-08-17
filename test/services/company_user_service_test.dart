import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/company_user_service.dart';

import 'company_user_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('CompanyUserService', () {
    late http.Client client;
    late CompanyUserService companyUserService;

    setUp(() {
      client = MockClient();
      companyUserService =
          CompanyUserService(client: client, baseUrl: 'https://api.test');
    });

    test('getCompanyUsers success', () async {
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

      final users = await companyUserService.getCompanyUsers(
        token: 'abc',
        companyId: 1,
      );

      expect(users.records, isEmpty);
    });

    test('addUserToCompany success', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "user@test.com", "role_name": "Viewer"}}',
          201,
        ),
      );

      final user = await companyUserService.addUserToCompany(
        token: 'abc',
        companyId: 1,
        companyUserAdd: CompanyUserAdd(email: 'user@test.com'),
      );

      expect(user.id, 1);
    });
  });
}
