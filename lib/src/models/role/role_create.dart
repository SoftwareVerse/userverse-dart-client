import 'dart:convert';

class RoleCreate {
  RoleCreate({
    required this.name,
    this.description,
  });

  factory RoleCreate.fromJson(String source) =>
      RoleCreate.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RoleCreate.fromMap(Map<String, dynamic> map) {
    return RoleCreate(
      name: map['name'] as String,
      description: map['description'] as String?,
    );
  }
  final String name;
  final String? description;

  RoleCreate copyWith({
    String? name,
    String? description,
  }) {
    return RoleCreate(
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
  String toString() => 'RoleCreate(name: $name, description: $description)';

  @override
  bool operator ==(covariant RoleCreate other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
