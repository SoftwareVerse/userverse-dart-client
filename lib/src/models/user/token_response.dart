import 'dart:convert';

class TokenResponseModel {
  TokenResponseModel({
    this.tokenType,
    required this.accessToken,
    required this.accessTokenExpiration,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory TokenResponseModel.fromJson(String source) =>
      TokenResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TokenResponseModel.fromMap(Map<String, dynamic> map) {
    return TokenResponseModel(
      tokenType: map['token_type'] as String?,
      accessToken: map['access_token'] as String,
      accessTokenExpiration: map['access_token_expiration'] as String,
      refreshToken: map['refresh_token'] as String,
      refreshTokenExpiration: map['refresh_token_expiration'] as String,
    );
  }
  final String? tokenType;
  final String accessToken;
  final String accessTokenExpiration;
  final String refreshToken;
  final String refreshTokenExpiration;

  TokenResponseModel copyWith({
    String? tokenType,
    String? accessToken,
    String? accessTokenExpiration,
    String? refreshToken,
    String? refreshTokenExpiration,
  }) {
    return TokenResponseModel(
      tokenType: tokenType ?? this.tokenType,
      accessToken: accessToken ?? this.accessToken,
      accessTokenExpiration:
          accessTokenExpiration ?? this.accessTokenExpiration,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpiration:
          refreshTokenExpiration ?? this.refreshTokenExpiration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token_type': tokenType,
      'access_token': accessToken,
      'access_token_expiration': accessTokenExpiration,
      'refresh_token': refreshToken,
      'refresh_token_expiration': refreshTokenExpiration,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TokenResponseModel(tokenType: $tokenType, accessToken: $accessToken, accessTokenExpiration: $accessTokenExpiration, refreshToken: $refreshToken, refreshTokenExpiration: $refreshTokenExpiration)';
  }

  @override
  bool operator ==(covariant TokenResponseModel other) {
    if (identical(this, other)) return true;

    return other.tokenType == tokenType &&
        other.accessToken == accessToken &&
        other.accessTokenExpiration == accessTokenExpiration &&
        other.refreshToken == refreshToken &&
        other.refreshTokenExpiration == refreshTokenExpiration;
  }

  @override
  int get hashCode {
    return tokenType.hashCode ^
        accessToken.hashCode ^
        accessTokenExpiration.hashCode ^
        refreshToken.hashCode ^
        refreshTokenExpiration.hashCode;
  }
}
