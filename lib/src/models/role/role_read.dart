import 'dart:convert';

class RoleRead {
  RoleRead({
    this.name,
    this.description,
  });

  factory RoleRead.fromJson(String source) =>
      RoleRead.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RoleRead.fromMap(Map<String, dynamic> map) {
    return RoleRead(
      name: map['name'] as String?,
      description: map['description'] as String?,
    );
  }
  final String? name;
  final String? description;

  RoleRead copyWith({
    String? name,
    String? description,
  }) {
    return RoleRead(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'RoleRead(name: $name, description: $description)';

  @override
  bool operator ==(covariant RoleRead other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
