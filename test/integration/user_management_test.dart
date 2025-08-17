import 'package:test/test.dart';
import 'package:userverse_dart_client/userverse_dart_client.dart';

void main() {
  group('User Management Integration Tests', () {
    late UserverseClient client;

    setUp(() {
      client = UserverseClient();
    });

    test('Login and get user', () async {
      // IMPORTANT: Replace with actual credentials for testing
      const username = 'YOUR_TEST_USERNAME';
      const password = 'YOUR_TEST_PASSWORD';

      if (username == 'YOUR_TEST_USERNAME' || password == 'YOUR_TEST_PASSWORD') {
        print('Skipping integration test: Please provide test credentials.');
        return;
      }

      final token = await client.users.login(
        username: username,
        password: password,
      );

      expect(token.accessToken, isNotEmpty);

      final user = await client.users.getMe(token: token.accessToken);

      expect(user.email, username);
    });
  });
}
