import 'package:userverse_dart_client/userverse_dart_client.dart';

void main() async {
  // 1. Create a client
  final client = UserverseClient();

  try {
    // 2. Login
    print('Logging in...');
    final token = await client.users.login(
      username: 'YOUR_USERNAME', // Replace with your username
      password: 'YOUR_PASSWORD', // Replace with your password
    );
    final accessToken = token.accessToken;
    print('Logged in successfully!');
    print('Access token: $accessToken');

    // Set the token for all subsequent requests
    client.setBearerToken(accessToken);

    // 3. Get current user
    print('\\nGetting current user...');
    final user = await client.users.getMe();
    print('Current user: ${user.email}');

    // 4. Create a company
    print('\\nCreating a company...');
    final company = await client.companies.createCompany(
      companyCreate: CompanyCreate(
        name: 'My Awesome Company',
        email: 'company@example.com',
      ),
    );
    print('Company created: ${company.name}');

    // 5. Add a user to the company
    print('\\nAdding a user to the company...');
    await client.companyUsers.addUserToCompany(
      companyId: company.id,
      companyUserAdd: CompanyUserAdd(email: 'new.user@example.com'),
    );
    print('User added to company');

  } catch (e) {
    print('An error occurred: $e');
  }
}
