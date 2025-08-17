// auth_util.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthUtil {
  /// Hashes a plaintext password using SHA-256 and returns the hex string.
  static String hashPassword(String plainPassword) {
    final bytes = utf8.encode(plainPassword);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Builds a Basic Auth header with "Authorization: Basic base64(email:hashedPassword)".
  ///
  /// Example usage:
  ///   final headers = AuthUtil.buildBasicAuthHeader(
  ///     email: user.email,
  ///     password: user.password,
  ///   );
  static Map<String, String> buildBasicAuthHeader({
    required String email,
    required String password,
  }) {
    final hashed = hashPassword(password);
    final creds = base64Encode(utf8.encode('$email:$hashed'));
    return {'Authorization': 'Basic $creds'};
  }
}