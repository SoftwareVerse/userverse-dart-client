import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class UserService {
  UserService({
    required http.Client client,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl;

  final http.Client _client;
  final String _baseUrl;

  Future<TokenResponse> login({
    required String username,
    required String password,
  }) async {
    final headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      'Content-Type': 'application/json',
    };
    final response = await _client.patch(
      Uri.parse('$_baseUrl/user/login'),
      headers: headers,
    );

    if (response.statusCode == 202) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      return TokenResponse.fromMap(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<UserRead> getMe({required String token}) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await _client.get(
      Uri.parse('$_baseUrl/user'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      return UserRead.fromMap(data);
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<UserRead> createUser({
    required String username,
    required String password,
    required UserCreate userCreate,
  }) async {
    final headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      'Content-Type': 'application/json',
    };
    final response = await _client.post(
      Uri.parse('$_baseUrl/user'),
      headers: headers,
      body: userCreate.toJson(),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      return UserRead.fromMap(data);
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<UserRead> updateUser({
    required String token,
    required UserUpdate userUpdate,
  }) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await _client.patch(
      Uri.parse('$_baseUrl/user'),
      headers: headers,
      body: userUpdate.toJson(),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      return UserRead.fromMap(data);
    } else {
      throw Exception('Failed to update user');
    }
  }
}
