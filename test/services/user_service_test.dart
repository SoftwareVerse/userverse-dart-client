import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/user_service.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('UserService', () {
    late http.Client client;
    late UserService userService;

    setUp(() {
      client = MockClient();
      userService = UserService(client: client, baseUrl: 'https://api.test');
    });

    test('login success', () async {
      when(
        client.patch(
          Uri.parse('https://api.test/user/login'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"access_token": "abc", "access_token_expiration": "exp", "refresh_token": "def", "refresh_token_expiration": "exp2"}}',
          202,
        ),
      );

      final token = await userService.login(
        username: 'test',
        password: 'password',
      );

      expect(token.accessToken, 'abc');
    });

    test('getMe success', () async {
      when(
        client.get(
          Uri.parse('https://api.test/user'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "test@test.com"}}',
          200,
        ),
      );

      final user = await userService.getMe(token: 'abc');

      expect(user.id, 1);
      expect(user.email, 'test@test.com');
    });

    test('createUser success', () async {
      when(
        client.post(
          Uri.parse('https://api.test/user'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "test@test.com"}}',
          201,
        ),
      );

      final user = await userService.createUser(
        username: 'test',
        password: 'password',
        userCreate: UserCreate(),
      );

      expect(user.id, 1);
    });

    test('updateUser success', () async {
      when(
        client.patch(
          Uri.parse('https://api.test/user'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"data": {"id": 1, "email": "test@test.com"}}',
          201,
        ),
      );

      final user = await userService.updateUser(
        token: 'abc',
        userUpdate: UserUpdate(),
      );

      expect(user.id, 1);
    });
  });
}
