import 'dart:convert';
import 'company_address.dart';

class CompanyCreate {
  CompanyCreate({
    this.name,
    this.description,
    this.industry,
    this.phoneNumber,
    required this.email,
    this.address,
  });

  factory CompanyCreate.fromJson(String source) =>
      CompanyCreate.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CompanyCreate.fromMap(Map<String, dynamic> map) {
    return CompanyCreate(
      name: map['name'] as String?,
      description: map['description'] as String?,
      industry: map['industry'] as String?,
      phoneNumber: map['phone_number'] as String?,
      email: map['email'] as String,
      address: map['address'] != null
          ? CompanyAddress.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }
  final String? name;
  final String? description;
  final String? industry;
  final String? phoneNumber;
  final String email;
  final CompanyAddress? address;

  CompanyCreate copyWith({
    String? name,
    String? description,
    String? industry,
    String? phoneNumber,
    String? email,
    CompanyAddress? address,
  }) {
    return CompanyCreate(
      name: name ?? this.name,
      description: description ?? this.description,
      industry: industry ?? this.industry,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'industry': industry,
      'phone_number': phoneNumber,
      'email': email,
      'address': address?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CompanyCreate(name: $name, description: $description, industry: $industry, phoneNumber: $phoneNumber, email: $email, address: $address)';
  }

  @override
  bool operator ==(covariant CompanyCreate other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.industry == industry &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        industry.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        address.hashCode;
  }
}
