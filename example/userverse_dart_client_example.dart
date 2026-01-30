import 'package:userverse_dart_client/userverse_dart_client.dart';

void main() async {
  // 1. Create a client
  // You can specify a custom baseUrl if needed:
  final client = UserverseClient(baseUrl: 'https://apps.oxillium-api.co.za/userverse');
  // final client = UserverseClient();

  try {
    // -------------------------------------------------------------------------
    // 2. Authentication (UserService)
    // -------------------------------------------------------------------------
    print('--- Authentication ---');
    print('Logging in...');
    final token = await client.users.login(
      username: 'YOUR_USERNAME', // Replace with your username
      password: 'YOUR_PASSWORD', // Replace with your password
    );
    final accessToken = token.accessToken;
    print('Logged in successfully!');
    print('Access token: $accessToken');

    // Set token for subsequent requests
    client.setAuthToken(accessToken);

    // -------------------------------------------------------------------------
    // 3. User Management (UserService)
    // -------------------------------------------------------------------------
    print('\n--- User Management ---');
    print('Getting current user...');
    final user = await client.users.getMe();
    print('Current user: ${user.email} (ID: ${user.id})');

    print('Updating current user...');
    final updatedUser = await client.users.updateUser(
      userUpdate: UserUpdate(firstName: 'UpdatedName'),
    );
    print('User updated: ${updatedUser.firstName}');

    print('Getting user companies...');
    final userCompanies = await client.users.getUserCompanies();
    print('User belongs to ${userCompanies.records.length} companies');

    // -------------------------------------------------------------------------
    // 4. Company Management (CompanyService)
    // -------------------------------------------------------------------------
    print('\n--- Company Management ---');
    print('Creating a company...');
    final companyName = 'Company-${DateTime.now().millisecondsSinceEpoch}';
    final company = await client.companies.createCompany(
      companyCreate: CompanyCreate(
        name: companyName,
        email: '$companyName@example.com',
      ),
    );
    print('Company created: ${company.name} (ID: ${company.id})');

    print('Getting company details...');
    final fetchedCompany = await client.companies.getCompany(
      companyId: company.id,
    );
    print('Fetched company: ${fetchedCompany.name}');

    print('Updating company...');
    final updatedCompany = await client.companies.updateCompany(
      companyId: company.id,
      companyUpdate: CompanyUpdate(name: '$companyName Updated'),
    );
    print('Company updated: ${updatedCompany.name}');

    // -------------------------------------------------------------------------
    // 5. Company User Management (CompanyUserService)
    // -------------------------------------------------------------------------
    print('\n--- Company User Management ---');
    print('Adding a user to the company...');
    // Note: The user email must exist in the system or be valid depending on backend logic
    final newUserEmail =
        'new.user.${DateTime.now().millisecondsSinceEpoch}@example.com';

    // In a real scenario, you might need to create this user first or use an existing one.
    // We'll attempt to add; if it fails (e.g. user not found), we catch it.
    try {
      await client.companyUsers.addUserToCompany(
        companyId: company.id,
        companyUserAdd: CompanyUserAdd(email: newUserEmail, role: 'member'),
      );
      print('User $newUserEmail added to company');
    } catch (e) {
      print('Could not add user (might not exist): $e');
    }

    print('Listing company users...');
    final companyUsers = await client.companyUsers.getCompanyUsers(
      companyId: company.id,
    );
    print('Company has ${companyUsers.records.length} users');

    if (companyUsers.records.isNotEmpty) {
      final userToRemove = companyUsers.records.firstWhere(
          (u) => u.email == newUserEmail,
          orElse: () => companyUsers.records.first);

      // Don't remove ourselves if we are the only one
      if (userToRemove.id != user.id) {
        print('Removing user ${userToRemove.email} from company...');
        await client.companyUsers.removeUserFromCompany(
          companyId: company.id,
          userId: userToRemove.id,
        );
        print('User removed');
      }
    }

    // -------------------------------------------------------------------------
    // 6. Company Role Management (CompanyRoleService)
    // -------------------------------------------------------------------------
    print('\n--- Company Role Management ---');
    print('Creating a new role...');
    final roleName = 'CustomRole_${DateTime.now().millisecondsSinceEpoch}';
    final role = await client.companyRoles.createRole(
      companyId: company.id,
      roleCreate: RoleCreate(
        name: roleName,
        description: 'A custom test role',
      ),
    );
    print('Role created: ${role.name}');

    print('Listing company roles...');
    final roles = await client.companyRoles.getCompanyRoles(
      companyId: company.id,
    );
    print('Company has ${roles.records.length} roles');

    print('Updating role...');
    if (role.name == null) {
      print('Role name is null, skipping update/delete');
    } else {
      final updatedRole = await client.companyRoles.updateRole(
        companyId: company.id,
        roleName: role.name!,
        roleUpdate: RoleUpdate(description: 'Updated description'),
      );
      print('Role updated: ${updatedRole.description}');

      print('Deleting role...');
      // When deleting a role, you often need to specify a replacement role
      // for any users who currently hold the role being deleted.
      await client.companyRoles.deleteRole(
        companyId: company.id,
        roleDelete: RoleDelete(
          roleNameToDelete: role.name!,
          replacementRoleName: 'member', // Assuming 'member' exists
        ),
      );
      print('Role deleted');
    }
  } catch (e) {
    print('\nAn error occurred:');
    if (e is ApiException) {
      print('Status Code: ${e.statusCode}');
      print('Message: ${e.message}');
      print('Response Body: ${e.responseBody}');
    } else {
      print(e);
    }
  }
}
