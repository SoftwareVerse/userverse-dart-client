import '../models/models.dart';
import '../utils/base_api.dart';
import '../utils/hash_password.dart';

class UserService {
  UserService(this._apiService);

  final BaseApiService _apiService;

  Future<TokenResponse> login({
    required String username,
    required String password,
  }) async {
    final hashedPassword = AuthUtil.hashPassword(password);
    final result = await _apiService.patch(
      '/user/login',
      basicAuthUsername: username,
      basicAuthPassword: hashedPassword,
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return TokenResponse.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to login',
        responseBody: result,
      );
    }
  }

  Future<UserRead> getMe() async {
    final result = await _apiService.get('/user/get');
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return UserRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to get user',
        responseBody: result,
      );
    }
  }

  Future<UserRead> createUser({
    required String username,
    required String password,
    required UserCreate userCreate,
  }) async {
    final hashedPassword = AuthUtil.hashPassword(password);
    final result = await _apiService.post(
      '/user',
      body: userCreate.toJson(),
      basicAuthUsername: username,
      basicAuthPassword: hashedPassword,
    );

    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return UserRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to create user',
        responseBody: result,
      );
    }
  }

  Future<UserRead> updateUser({required UserUpdate userUpdate}) async {
    final result = await _apiService.patch(
      '/user/update',
      body: userUpdate.toJson(),
    );

    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return UserRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to update user',
        responseBody: result,
      );
    }
  }

  Future<void> resendVerification({required String email}) async {
    final result = await _apiService.post(
      '/user/resend-verification',
      body: {'email': email},
    );

    if (!result['success']) {
      throw ApiException(
        message: result['message'] ?? 'Failed to resend verification',
        responseBody: result,
      );
    }
  }

  Future<void> verify({required String token}) async {
    final result = await _apiService.get(
      '/user/verify',
      queryParams: {'token': token},
    );

    if (!result['success']) {
      throw ApiException(
        message: result['message'] ?? 'Failed to verify user',
        responseBody: result,
      );
    }
  }

  Future<void> passwordResetRequest({required String email}) async {
    final result = await _apiService.patch(
      '/password-reset/request',
      queryParams: {'email': email},
    );

    if (!result['success']) {
      throw ApiException(
        message: result['message'] ?? 'Failed to request password reset',
        responseBody: result,
      );
    }
  }

  Future<void> validateOtp({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final result = await _apiService.patch(
      '/password-reset/validate-otp',
      body: {
        'email': email,
        'otp': otp,
        'new_password': newPassword,
      },
    );

    if (!result['success']) {
      throw ApiException(
        message: result['message'] ?? 'Failed to validate OTP',
        responseBody: result,
      );
    }
  }

  Future<PaginatedPageResponse<CompanyRead>> getUserCompanies({
    int? limit,
    int? page,
  }) async {
    final queryParameters = <String, String>{};
    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }
    if (page != null) {
      queryParameters['page'] = page.toString();
    }
    final result = await _apiService.get(
      '/user/companies',
      queryParams: queryParameters,
    );

    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return PaginatedPageResponse.fromMap(data, CompanyRead.fromMap);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to get user companies',
        responseBody: result,
      );
    }
  }
}
