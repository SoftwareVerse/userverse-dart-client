import 'dart:convert';

class CompanyUserRead {
  CompanyUserRead({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    this.isSuperuser,
    required this.roleName,
  });

  factory CompanyUserRead.fromJson(String source) =>
      CompanyUserRead.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CompanyUserRead.fromMap(Map<String, dynamic> map) {
    return CompanyUserRead(
      id: map['id'] as int,
      firstName: map['first_name'] as String?,
      lastName: map['last_name'] as String?,
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String?,
      isSuperuser: map['is_superuser'] as bool?,
      roleName: map['role_name'] as String,
    );
  }
  final int id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final bool? isSuperuser;
  final String roleName;

  CompanyUserRead copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    bool? isSuperuser,
    String? roleName,
  }) {
    return CompanyUserRead(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      roleName: roleName ?? this.roleName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'is_superuser': isSuperuser,
      'role_name': roleName,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CompanyUserRead(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, isSuperuser: $isSuperuser, roleName: $roleName)';
  }

  @override
  bool operator ==(covariant CompanyUserRead other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.isSuperuser == isSuperuser &&
        other.roleName == roleName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        isSuperuser.hashCode ^
        roleName.hashCode;
  }
}
