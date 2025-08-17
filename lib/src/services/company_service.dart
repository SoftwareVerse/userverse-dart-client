import '../models/models.dart';
import '../utils/base_api.dart';

class CompanyService {
  CompanyService({this._apiService = const BaseApiService(
    http.Client(),
    'https://api.example.com', // Replace with your actual base URL
  )});

  final BaseApiService _apiService;

  Future<CompanyRead> createCompany(
      {required CompanyCreate companyCreate}) async {
    final result = await _apiService.post(
      '/company',
      body: companyCreate.toJson(),
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return CompanyRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to create company',
        responseBody: result,
      );
    }
  }

  Future<CompanyRead> getCompany({
    int? companyId,
    String? email,
  }) async {
    final queryParameters = <String, String>{};
    if (companyId != null) {
      queryParameters['company_id'] = companyId.toString();
    }
    if (email != null) {
      queryParameters['email'] = email;
    }
    final result = await _apiService.get(
      '/company',
      queryParams: queryParameters,
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return CompanyRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to get company',
        responseBody: result,
      );
    }
  }

  Future<CompanyRead> updateCompany({
    required int companyId,
    required CompanyUpdate companyUpdate,
  }) async {
    final result = await _apiService.patch(
      '/company/$companyId',
      body: companyUpdate.toJson(),
    );
    if (result['success']) {
      final data = result['data'] as Map<String, dynamic>;
      return CompanyRead.fromMap(data);
    } else {
      throw ApiException(
        message: result['message'] ?? 'Failed to update company',
        responseBody: result,
      );
    }
  }
}
