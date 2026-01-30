import 'package:http/http.dart' as http;
import '../services/company_role_service.dart';
import '../services/company_service.dart';
import '../services/company_user_service.dart';
import '../services/user_service.dart';
import '../utils/base_api.dart';

class UserverseClient {
  UserverseClient({
    http.Client? client,
    this.baseUrl = 'https://main-api.oxillium-backend.com',
  }) : _client = client ?? http.Client() {
    _apiService = BaseApiService(_client, baseUrl);
    users = UserService(_apiService);
    companies = CompanyService(_apiService);
    companyRoles = CompanyRoleService(_apiService);
    companyUsers = CompanyUserService(_apiService);
  }

  final String baseUrl;
  final http.Client _client;
  late final BaseApiService _apiService;

  late final UserService users;
  late final CompanyService companies;
  late final CompanyRoleService companyRoles;
  late final CompanyUserService companyUsers;

  /// Sets the Bearer token for all services.
  void setAuthToken(String token) {
    _apiService.setBearerToken(token);
  }

  /// Clears the Bearer token.
  void clearAuthToken() {
    _apiService.clearBearerToken();
  }
}
