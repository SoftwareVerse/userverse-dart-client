import '../models/models.dart';
import '../utils/base_api.dart';

class CompanyUserService {
  CompanyUserService(
    this._apiService,
  );

  final BaseApiService _apiService;

  Future<PaginatedPageResponse<CompanyUserRead>> getCompanyUsers({
    required int companyId,
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
      '/company/$companyId/users',
      queryParams: queryParameters,
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return PaginatedPageResponse.fromMap(data, CompanyUserRead.fromMap);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to get company users',
        responseBody: result,
      );
    }
  }

  Future<CompanyUserRead> addUserToCompany({
    required int companyId,
    required CompanyUserAdd companyUserAdd,
  }) async {
    final result = await _apiService.post(
      '/company/$companyId/users',
      body: companyUserAdd.toJson(),
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return CompanyUserRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to add user to company',
        responseBody: result,
      );
    }
  }

  Future<void> removeUserFromCompany({
    required int companyId,
    required int userId,
  }) async {
    final result = await _apiService.delete(
      '/company/$companyId/user/$userId',
    );
    if (!result['success']) {
      throw ApiException(
        message: result['message'] ?? 'Failed to remove user from company',
        responseBody: result,
      );
    }
  }
}
