import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class CompanyRoleService {
  CompanyRoleService({
    required http.Client client,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl;

  final http.Client _client;
  final String _baseUrl;

  Future<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      return Future.value(fromJson(data));
    } else {
      throw Exception('Failed to perform operation');
    }
  }

  Future<PaginatedPageResponse<RoleRead>> getCompanyRoles({
    required String token,
    required int companyId,
    int? limit,
    int? page,
  }) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final queryParameters = <String, String>{};
    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }
    if (page != null) {
      queryParameters['page'] = page.toString();
    }
    final uri = Uri.parse('$_baseUrl/company/$companyId/roles').replace(
      queryParameters: queryParameters,
    );
    final response = await _client.get(
      uri,
      headers: headers,
    );
    return _handleResponse(
      response,
      (data) => PaginatedPageResponse.fromMap(data, RoleRead.fromMap),
    );
  }

  Future<RoleRead> createRole({
    required String token,
    required int companyId,
    required RoleCreate roleCreate,
  }) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await _client.post(
      Uri.parse('$_baseUrl/company/$companyId/role'),
      headers: headers,
      body: roleCreate.toJson(),
    );
    return _handleResponse(response, RoleRead.fromMap);
  }

  Future<RoleRead> updateRole({
    required String token,
    required int companyId,
    required String roleName,
    required RoleUpdate roleUpdate,
  }) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await _client.patch(
      Uri.parse('$_baseUrl/company/$companyId/role/$roleName'),
      headers: headers,
      body: roleUpdate.toJson(),
    );
    return _handleResponse(response, RoleRead.fromMap);
  }

  Future<void> deleteRole({
    required String token,
    required int companyId,
    required RoleDelete roleDelete,
  }) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    await _client.delete(
      Uri.parse('$_baseUrl/company/$companyId/role'),
      headers: headers,
      body: roleDelete.toJson(),
    );
  }
}
