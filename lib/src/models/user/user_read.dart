import 'dart:convert';

class UserRead {
  UserRead({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    this.isSuperuser,
  });

  factory UserRead.fromJson(String source) =>
      UserRead.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserRead.fromMap(Map<String, dynamic> map) {
    return UserRead(
      id: map['id'] as int,
      firstName: map['first_name'] as String?,
      lastName: map['last_name'] as String?,
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String?,
      isSuperuser: map['is_superuser'] as bool?,
    );
  }
  final int id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final bool? isSuperuser;

  UserRead copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    bool? isSuperuser,
  }) {
    return UserRead(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isSuperuser: isSuperuser ?? this.isSuperuser,
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
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserRead(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, isSuperuser: $isSuperuser)';
  }

  @override
  bool operator ==(covariant UserRead other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.isSuperuser == isSuperuser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        isSuperuser.hashCode;
  }
}
