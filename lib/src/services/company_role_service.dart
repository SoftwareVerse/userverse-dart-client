import '../models/models.dart';
import '../utils/base_api.dart';

class CompanyRoleService {
  CompanyRoleService(this._apiService);

  final BaseApiService _apiService;

  Future<PaginatedPageResponse<RoleRead>> getCompanyRoles({
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
      '/company/$companyId/roles',
      queryParams: queryParameters,
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return PaginatedPageResponse.fromMap(data, RoleRead.fromMap);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to get company roles',
        responseBody: result,
      );
    }
  }

  Future<RoleRead> createRole({
    required int companyId,
    required RoleCreate roleCreate,
  }) async {
    final result = await _apiService.post(
      '/company/$companyId/role',
      body: roleCreate.toJson(),
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return RoleRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to create role',
        responseBody: result,
      );
    }
  }

  Future<RoleRead> updateRole({
    required int companyId,
    required String roleName,
    required RoleUpdate roleUpdate,
  }) async {
    final result = await _apiService.patch(
      '/company/$companyId/role/$roleName',
      body: roleUpdate.toJson(),
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return RoleRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to update role',
        responseBody: result,
      );
    }
  }

  Future<void> deleteRole({
    required int companyId,
    required RoleDelete roleDelete,
  }) async {
    final result = await _apiService.delete(
      '/company/$companyId/role',
      body: roleDelete.toJson(),
    );
    if (!result['success']) {
      throw ApiException(
        message: result['message'] ?? 'Failed to delete role',
        responseBody: result,
      );
    }
  }
}
