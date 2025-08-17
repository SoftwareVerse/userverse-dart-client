import 'dart:convert';

class RoleDelete {
  RoleDelete({
    required this.replacementRoleName,
    required this.roleNameToDelete,
  });

  factory RoleDelete.fromJson(String source) =>
      RoleDelete.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RoleDelete.fromMap(Map<String, dynamic> map) {
    return RoleDelete(
      replacementRoleName: map['replacement_role_name'] as String,
      roleNameToDelete: map['role_name_to_delete'] as String,
    );
  }
  final String replacementRoleName;
  final String roleNameToDelete;

  RoleDelete copyWith({
    String? replacementRoleName,
    String? roleNameToDelete,
  }) {
    return RoleDelete(
      replacementRoleName: replacementRoleName ?? this.replacementRoleName,
      roleNameToDelete: roleNameToDelete ?? this.roleNameToDelete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'replacement_role_name': replacementRoleName,
      'role_name_to_delete': roleNameToDelete,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RoleDelete(replacementRoleName: $replacementRoleName, roleNameToDelete: $roleNameToDelete)';

  @override
  bool operator ==(covariant RoleDelete other) {
    if (identical(this, other)) return true;

    return other.replacementRoleName == replacementRoleName &&
        other.roleNameToDelete == roleNameToDelete;
  }

  @override
  int get hashCode =>
      replacementRoleName.hashCode ^ roleNameToDelete.hashCode;
}
