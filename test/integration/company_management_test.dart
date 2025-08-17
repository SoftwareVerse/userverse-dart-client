import 'package:test/test.dart';
import 'package:userverse_dart_client/userverse_dart_client.dart';

void main() {
  group('Company Management Integration Tests', () {
    late UserverseClient client;
    late String token;

    setUpAll(() async {
      client = UserverseClient();
      // IMPORTANT: Replace with actual credentials for testing
      const username = 'YOUR_TEST_USERNAME';
      const password = 'YOUR_TEST_PASSWORD';

      if (username == 'YOUR_TEST_USERNAME' || password == 'YOUR_TEST_PASSWORD') {
        print('Skipping integration tests: Please provide test credentials.');
        return;
      }

      final tokenResponse = await client.users.login(
        username: username,
        password: password,
      );
      token = tokenResponse.accessToken;
    });

    test('Create, get and update company', () async {
      if (token.isEmpty) {
        print('Skipping test because login failed.');
        return;
      }

      final companyEmail =
          'test-company-${DateTime.now().millisecondsSinceEpoch}@test.com';

      // Create company
      final createdCompany = await client.companies.createCompany(
        token: token,
        companyCreate: CompanyCreate(
          name: 'Test Company',
          email: companyEmail,
        ),
      );
      expect(createdCompany.email, companyEmail);

      // Get company
      final gotCompany = await client.companies.getCompany(
        token: token,
        companyId: createdCompany.id,
      );
      expect(gotCompany.id, createdCompany.id);

      // Update company
      final updatedCompany = await client.companies.updateCompany(
        token: token,
        companyId: createdCompany.id,
        companyUpdate: CompanyUpdate(
          name: 'Updated Test Company',
        ),
      );
      expect(updatedCompany.name, 'Updated Test Company');
    });
  });
}
