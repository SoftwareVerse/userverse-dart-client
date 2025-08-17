import 'dart:convert';

class RoleUpdate {
  RoleUpdate({
    this.name,
    this.description,
  });

  factory RoleUpdate.fromJson(String source) =>
      RoleUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RoleUpdate.fromMap(Map<String, dynamic> map) {
    return RoleUpdate(
      name: map['name'] as String?,
      description: map['description'] as String?,
    );
  }
  final String? name;
  final String? description;

  RoleUpdate copyWith({
    String? name,
    String? description,
  }) {
    return RoleUpdate(
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
  String toString() => 'RoleUpdate(name: $name, description: $description)';

  @override
  bool operator ==(covariant RoleUpdate other) {
    if (identical(this, other)) return true;

    return other.name == name && other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
