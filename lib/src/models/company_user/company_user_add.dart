import 'dart:convert';

class CompanyUserAdd {
  CompanyUserAdd({
    required this.email,
    this.role,
  });

  factory CompanyUserAdd.fromJson(String source) =>
      CompanyUserAdd.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CompanyUserAdd.fromMap(Map<String, dynamic> map) {
    return CompanyUserAdd(
      email: map['email'] as String,
      role: map['role'] as String?,
    );
  }
  final String email;
  final String? role;

  CompanyUserAdd copyWith({
    String? email,
    String? role,
  }) {
    return CompanyUserAdd(
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'role': role,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CompanyUserAdd(email: $email, role: $role)';

  @override
  bool operator ==(covariant CompanyUserAdd other) {
    if (identical(this, other)) return true;

    return other.email == email && other.role == role;
  }

  @override
  int get hashCode => email.hashCode ^ role.hashCode;
}
