import '../models/models.dart';
import '../utils/base_api.dart';
import '../utils/hash_password.dart';

class UserService {
  UserService(
    this._apiService,
  );

  final BaseApiService _apiService;

  Future<ResponseModel<TokenResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final basicHeader = AuthUtil.buildBasicAuthHeader(
      email: email,
      password: password,
    );

    final result = await _apiService.patch(
      'user/login',
      additionalHeaders: basicHeader,
    );

    return ResponseModel<TokenResponseModel>.fromJson(
      result,
      (data) => TokenResponseModel.fromJson(data as String),
    );
  }

  Future<UserRead> getMe() async {
    final result = await _apiService.get('/user');
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
      '/user',
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
}
