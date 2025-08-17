import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:userverse_dart_client/src/models/models.dart';
import 'package:userverse_dart_client/src/services/user_service.dart';
import 'package:userverse_dart_client/src/utils/base_api.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([BaseApiService])
void main() {
  group('UserService', () {
    late MockBaseApiService mockBaseApiService;
    late UserService userService;

    setUp(() {
      mockBaseApiService = MockBaseApiService();
      userService = UserService(mockBaseApiService);
    });

    test('login success', () async {
      when(
        mockBaseApiService.patch(
          any,
          basicAuthUsername: anyNamed('basicAuthUsername'),
          basicAuthPassword: anyNamed('basicAuthPassword'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {
            'access_token': 'abc',
            'access_token_expiration': 'exp',
            'refresh_token': 'def',
            'refresh_token_expiration': 'exp2'
          },
        },
      );

      final token = await userService.login(
        username: 'test',
        password: 'password',
      );

      expect(token.accessToken, 'abc');
    });

    test('getMe success', () async {
      when(mockBaseApiService.get(any)).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'test@test.com'},
        },
      );

      final user = await userService.getMe();

      expect(user.id, 1);
      expect(user.email, 'test@test.com');
    });

    test('createUser success', () async {
      when(
        mockBaseApiService.post(
          any,
          body: anyNamed('body'),
          basicAuthUsername: anyNamed('basicAuthUsername'),
          basicAuthPassword: anyNamed('basicAuthPassword'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'test@test.com'},
        },
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
        mockBaseApiService.patch(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {'id': 1, 'email': 'test@test.com'},
        },
      );

      final user = await userService.updateUser(
        userUpdate: UserUpdate(),
      );

      expect(user.id, 1);
    });
  });
}
