import 'dart:convert';

class UserUpdate {
  UserUpdate({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
  });

  factory UserUpdate.fromJson(String source) =>
      UserUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserUpdate.fromMap(Map<String, dynamic> map) {
    return UserUpdate(
      firstName: map['first_name'] as String?,
      lastName: map['last_name'] as String?,
      phoneNumber: map['phone_number'] as String?,
      password: map['password'] as String?,
    );
  }
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? password;

  UserUpdate copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? password,
  }) {
    return UserUpdate(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserUpdate(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, password: $password)';
  }

  @override
  bool operator ==(covariant UserUpdate other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.password == password;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        password.hashCode;
  }
}
