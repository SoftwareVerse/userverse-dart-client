import 'dart:convert';
import 'company_address.dart';

class CompanyRead {
  CompanyRead({
    required this.id,
    this.name,
    this.description,
    this.apiKey,
    this.industry,
    this.phoneNumber,
    required this.email,
    this.address,
  });

  factory CompanyRead.fromJson(String source) =>
      CompanyRead.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CompanyRead.fromMap(Map<String, dynamic> map) {
    return CompanyRead(
      id: map['id'] as int,
      name: map['name'] as String?,
      description: map['description'] as String?,
      apiKey: map['api_key'] as String?,
      industry: map['industry'] as String?,
      phoneNumber: map['phone_number'] as String?,
      email: map['email'] as String,
      address: map['address'] != null
          ? CompanyAddress.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }
  final int id;
  final String? name;
  final String? description;
  final String? apiKey;
  final String? industry;
  final String? phoneNumber;
  final String email;
  final CompanyAddress? address;

  CompanyRead copyWith({
    int? id,
    String? name,
    String? description,
    String? apiKey,
    String? industry,
    String? phoneNumber,
    String? email,
    CompanyAddress? address,
  }) {
    return CompanyRead(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      apiKey: apiKey ?? this.apiKey,
      industry: industry ?? this.industry,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'api_key': apiKey,
      'industry': industry,
      'phone_number': phoneNumber,
      'email': email,
      'address': address?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CompanyRead(id: $id, name: $name, description: $description, apiKey: $apiKey, industry: $industry, phoneNumber: $phoneNumber, email: $email, address: $address)';
  }

  @override
  bool operator ==(covariant CompanyRead other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.apiKey == apiKey &&
        other.industry == industry &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        apiKey.hashCode ^
        industry.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        address.hashCode;
  }
}
