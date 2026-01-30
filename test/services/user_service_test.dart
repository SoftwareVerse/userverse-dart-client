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
        userCreate: UserCreate(firstName: 'Test'),
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

    test('resendVerification success', () async {
      when(
        mockBaseApiService.post(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {'success': true},
      );

      await userService.resendVerification(email: 'test@test.com');
      verify(mockBaseApiService.post(
        '/user/resend-verification',
        body: {'email': 'test@test.com'},
      )).called(1);
    });

    test('verify success', () async {
      when(
        mockBaseApiService.get(
          any,
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer(
        (_) async => {'success': true},
      );

      await userService.verify(token: 'token123');
      verify(mockBaseApiService.get(
        '/user/verify',
        queryParams: {'token': 'token123'},
      )).called(1);
    });

    test('passwordResetRequest success', () async {
      when(
        mockBaseApiService.patch(
          any,
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer(
        (_) async => {'success': true},
      );

      await userService.passwordResetRequest(email: 'test@test.com');
      verify(mockBaseApiService.patch(
        '/password-reset/request',
        queryParams: {'email': 'test@test.com'},
      )).called(1);
    });

    test('validateOtp success', () async {
      when(
        mockBaseApiService.patch(
          any,
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => {'success': true},
      );

      await userService.validateOtp(
        email: 'test@test.com',
        otp: '123456',
        newPassword: 'newPassword',
      );
      verify(mockBaseApiService.patch(
        '/password-reset/validate-otp',
        body: {
          'email': 'test@test.com',
          'otp': '123456',
          'new_password': 'newPassword',
        },
      )).called(1);
    });

    test('getUserCompanies success', () async {
      when(
        mockBaseApiService.get(
          any,
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer(
        (_) async => {
          'success': true,
          'data': {
            'records': [
              {
                'id': 1,
                'name': 'Company A',
                'email': 'company@test.com',
                'company_address': {'address': '123 St'}
              }
            ],
            'pagination': {
              'total_records': 1,
              'limit': 10,
              'page': 1,
              'total_pages': 1
            }
          },
        },
      );

      final response = await userService.getUserCompanies(page: 1, limit: 10);

      expect(response.records.length, 1);
      expect(response.records.first.name, 'Company A');
      verify(mockBaseApiService.get(
        '/user/companies',
        queryParams: {'limit': '10', 'page': '1'},
      )).called(1);
    });
  });
}
