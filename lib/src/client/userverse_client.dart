import 'package:http/http.dart' as http;
import '../services/company_role_service.dart';
import '../services/company_service.dart';
import '../services/company_user_service.dart';
import '../services/user_service.dart';

class UserverseClient {
  UserverseClient({
    http.Client? client,
    this.baseUrl = 'https://main-api.oxillium-backend.com',
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  late final UserService users = UserService(
    client: _client,
    baseUrl: baseUrl,
  );

  late final CompanyService companies = CompanyService(
    client: _client,
    baseUrl: baseUrl,
  );

  late final CompanyRoleService companyRoles = CompanyRoleService(
    client: _client,
    baseUrl: baseUrl,
  );

  late final CompanyUserService companyUsers = CompanyUserService(
    client: _client,
    baseUrl: baseUrl,
  );
}
