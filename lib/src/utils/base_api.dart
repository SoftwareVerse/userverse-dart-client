import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

/// Custom API Exception for network/timeouts or low‐level errors.
class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic responseBody;

  ApiException({
    this.statusCode,
    required this.message,
    this.responseBody,
  });

  @override
  String toString() {
    var details = 'ApiException: Status $statusCode - $message';
    if (responseBody != null) {
      details += '\nResponse Body: $responseBody';
    }
    return details;
  }
}

/// Base API Service that wraps HTTP calls and injects a `success` boolean
/// into every response JSON map based on the HTTP status code.
class BaseApiService {
  final http.Client _client;
  final String _baseUrl;
  String? _bearerToken;

  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  BaseApiService(this._client, this._baseUrl);

  /// Sets the Bearer token for authenticated requests.
  void setBearerToken(String? token) {
    _bearerToken = token;
  }

  /// Clears the Bearer token.
  void clearBearerToken() {
    _bearerToken = null;
  }

  /// Builds the full URL from an endpoint string.
  String _buildUrl(String endpoint) {
    if (endpoint.startsWith('/')) {
      endpoint = endpoint.substring(1);
    }
    return '$_baseUrl/$endpoint';
  }

  /// Merges default headers, bearer auth, and any additional headers.
  Map<String, String> _prepareHeaders([Map<String, String>? additionalHeaders]) {
    final headers = {..._defaultHeaders};

    if (_bearerToken != null) {
      headers['Authorization'] = 'Bearer $_bearerToken';

    }
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    return headers;
  }

  /// Processes the HTTP response:
  /// - If statusCode is 2xx, returns decoded JSON (or `{}`) plus `"success": true`.
  /// - If statusCode is non-2xx, extracts `"detail"` or validation errors
  ///   (or raw text) and returns a map with `"success": false` and `"message": <extracted>`.
  Map<String, dynamic> _processResponse(http.Response response) {
    final bodyString = utf8.decode(response.bodyBytes);
    Map<String, dynamic>? decodedJson;

    if (bodyString.isNotEmpty) {
      try {
        decodedJson = jsonDecode(bodyString) as Map<String, dynamic>;
      } catch (_) {
        // If decoding fails, leave decodedJson null.
      }
    }

    // ─────────── Success (2xx) ───────────
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final result = decodedJson != null
          ? Map<String, dynamic>.from(decodedJson)
          : <String, dynamic>{};
      result['success'] = true;
      return result;
    }

    // ─────────── Error (non-2xx) ───────────
    final Map<String, dynamic> errorMap = {'success': false};

    if (decodedJson != null && decodedJson.containsKey('detail')) {
      final detail = decodedJson['detail'];

      // Case A: { "detail": { "message": "...", "error": "..." } }
      if (detail is Map<String, dynamic>) {
        if (detail.containsKey('message')) {
          errorMap['message'] = detail['message'] as String;
        } else {
          errorMap['message'] = 'Unknown error';
        }
        if (detail.containsKey('error')) {
          errorMap['error'] = detail['error'] as String;
        }
      }
      // Case B: 422 validation errors like:
      // { "detail": [ { "loc": [...], "msg": "...", "type": "..." }, ... ] }
      else if (detail is List && detail.isNotEmpty && detail.first is Map<String, dynamic>) {
        final firstError = detail.first as Map<String, dynamic>;
        if (firstError.containsKey('msg')) {
          errorMap['message'] = firstError['msg'] as String;
        } else {
          errorMap['message'] = 'Validation failed';
        }
        errorMap['validation'] = detail;
      }
      // Case C: detail is just a string
      else if (detail is String) {
        errorMap['message'] = detail;
      } else {
        errorMap['message'] = 'Unexpected error format';
      }
    }
    // If no "detail" but bodyString has content, use raw text
    else if (bodyString.isNotEmpty) {
      errorMap['message'] = bodyString;
    } else {
      errorMap['message'] = 'HTTP ${response.statusCode} Error';
    }

    return errorMap;
  }

  /// Wraps a request action in common try/catch, returning either a success
  /// map with `"success": true` or an error map with `"success": false`.
  Future<Map<String, dynamic>> _makeRequest(
    Future<http.Response> Function() requestAction,
  ) async {
    try {
      final response = await requestAction();
      print('HTTP ${response.statusCode} ${response.request?.method} ${response.request?.url}');
      return _processResponse(response);
    } on TimeoutException catch (e) {
      return {
        'success': false,
        'message': 'Request timed out: ${e.message}',
      };
    } on http.ClientException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error: ${e.toString()}',
      };
    }
  }

  // --- Public HTTP Methods ---

  /// GET request (optionally with query parameters or additional headers).
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? additionalHeaders,
  }) async {

    final uri =
        Uri.parse(_buildUrl(endpoint)).replace(queryParameters: queryParams);
    return _makeRequest(
      () => _client.get(uri, headers: _prepareHeaders(additionalHeaders)),
    );
  }

  /// POST request. If basicAuthUsername/password are provided, they override Bearer.
  Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? additionalHeaders,
    String? basicAuthUsername,
    String? basicAuthPassword,
    Map<String, String>? queryParams,
  }) async {
    final headers = _prepareHeaders(additionalHeaders);
    if (basicAuthUsername != null && basicAuthPassword != null) {
      final creds =
          base64Encode(utf8.encode('$basicAuthUsername:$basicAuthPassword'));
      headers['Authorization'] = 'Basic $creds';
    }
    final uri =
        Uri.parse(_buildUrl(endpoint)).replace(queryParameters: queryParams);
    return _makeRequest(
      () => _client.post(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  /// PATCH request (JSON body).
  Future<Map<String, dynamic>> patch(
    String endpoint, {
    dynamic body,
    Map<String, String>? additionalHeaders,
    String? basicAuthUsername,
    String? basicAuthPassword,
    Map<String, String>? queryParams,
  }) async {
    final headers = _prepareHeaders(additionalHeaders);
    if (basicAuthUsername != null && basicAuthPassword != null) {
      final creds = base64Encode(
          utf8.encode('$basicAuthUsername:$basicAuthPassword'));
      headers['Authorization'] = 'Basic $creds';
    }
    final uri =
        Uri.parse(_buildUrl(endpoint)).replace(queryParameters: queryParams);
    return _makeRequest(
      () => _client.patch(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  /// PUT request (JSON body).
  Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic body,
    Map<String, String>? additionalHeaders,
    Map<String, String>? queryParams,
  }) async {
    final uri =
        Uri.parse(_buildUrl(endpoint)).replace(queryParameters: queryParams);
    return _makeRequest(
      () => _client.put(
        uri,
        headers: _prepareHeaders(additionalHeaders),
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  /// DELETE request (allows a JSON body).
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    dynamic body,
    Map<String, String>? additionalHeaders,
    Map<String, String>? queryParams,
  }) async {
    final uri =
        Uri.parse(_buildUrl(endpoint)).replace(queryParameters: queryParams);
    final request = http.Request('DELETE', uri);
    request.headers.addAll(_prepareHeaders(additionalHeaders));
    if (body != null) {
      request.body = jsonEncode(body);
    }
    return _makeRequest(() async {
      final streamed = await _client.send(request);
      return http.Response.fromStream(streamed);
    });
  }
}