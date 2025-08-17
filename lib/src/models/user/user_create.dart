import 'dart:convert';

class UserCreate {
  UserCreate({
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  factory UserCreate.fromJson(String source) =>
      UserCreate.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserCreate.fromMap(Map<String, dynamic> map) {
    return UserCreate(
      firstName: map['first_name'] as String?,
      lastName: map['last_name'] as String?,
      phoneNumber: map['phone_number'] as String?,
    );
  }
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  UserCreate copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) {
    return UserCreate(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UserCreate(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(covariant UserCreate other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ phoneNumber.hashCode;
}
