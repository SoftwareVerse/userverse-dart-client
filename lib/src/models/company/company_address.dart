import 'dart:convert';

class CompanyAddress {
  CompanyAddress({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory CompanyAddress.fromJson(String source) =>
      CompanyAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CompanyAddress.fromMap(Map<String, dynamic> map) {
    return CompanyAddress(
      street: map['street'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      postalCode: map['postal_code'] as String?,
      country: map['country'] as String?,
    );
  }
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  CompanyAddress copyWith({
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    return CompanyAddress(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CompanyAddress(street: $street, city: $city, state: $state, postalCode: $postalCode, country: $country)';
  }

  @override
  bool operator ==(covariant CompanyAddress other) {
    if (identical(this, other)) return true;

    return other.street == street &&
        other.city == city &&
        other.state == state &&
        other.postalCode == postalCode &&
        other.country == country;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        city.hashCode ^
        state.hashCode ^
        postalCode.hashCode ^
        country.hashCode;
  }
}
