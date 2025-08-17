import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/company_service.dart';


@GenerateMocks([http.Client])
void main() {
  group('CompanyService', () {
    late http.Client client;
    late CompanyService companyService;

    setUp(() {
      client = MockClient();
      companyService =
          CompanyService(client: client, baseUrl: 'https://api.test');
    });

    test('createCompany success', () async {
      when(
        client.post(
          Uri.parse('https://api.test/company'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "company@test.com"}}',
          201,
        ),
      );

      final company = await companyService.createCompany(
        token: 'abc',
        companyCreate: CompanyCreate(email: 'company@test.com'),
      );

      expect(company.id, 1);
    });

    test('getCompany success', () async {
      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "company@test.com"}}',
          200,
        ),
      );

      final company = await companyService.getCompany(
        token: 'abc',
        companyId: 1,
      );

      expect(company.id, 1);
    });

    test('updateCompany success', () async {
      when(
        client.patch(
          Uri.parse('https://api.test/company/1'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "company@test.com"}}',
          200,
        ),
      );

      final company = await companyService.updateCompany(
        token: 'abc',
        companyId: 1,
        companyUpdate: CompanyUpdate(),
      );

      expect(company.id, 1);
    });
  });
}
