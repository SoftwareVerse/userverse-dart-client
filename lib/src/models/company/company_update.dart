import 'dart:convert';
import 'company_address.dart';

class CompanyUpdate {
  CompanyUpdate({
    this.name,
    this.description,
    this.industry,
    this.phoneNumber,
    this.address,
  });

  factory CompanyUpdate.fromJson(String source) =>
      CompanyUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CompanyUpdate.fromMap(Map<String, dynamic> map) {
    return CompanyUpdate(
      name: map['name'] as String?,
      description: map['description'] as String?,
      industry: map['industry'] as String?,
      phoneNumber: map['phone_number'] as String?,
      address: map['address'] != null
          ? CompanyAddress.fromMap(map['address'] as Map<String, dynamic>)
          : null,
    );
  }
  final String? name;
  final String? description;
  final String? industry;
  final String? phoneNumber;
  final CompanyAddress? address;

  CompanyUpdate copyWith({
    String? name,
    String? description,
    String? industry,
    String? phoneNumber,
    CompanyAddress? address,
  }) {
    return CompanyUpdate(
      name: name ?? this.name,
      description: description ?? this.description,
      industry: industry ?? this.industry,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'industry': industry,
      'phone_number': phoneNumber,
      'address': address?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CompanyUpdate(name: $name, description: $description, industry: $industry, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(covariant CompanyUpdate other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.industry == industry &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        industry.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode;
  }
}
