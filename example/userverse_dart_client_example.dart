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
    print('Logged in successfully!');
    print('Access token: ${token.accessToken}');

    // 3. Get current user
    print('\\nGetting current user...');
    final user = await client.users.getMe(token: token.accessToken);
    print('Current user: ${user.email}');

    // 4. Create a company
    print('\\nCreating a company...');
    final company = await client.companies.createCompany(
      token: token.accessToken,
      companyCreate: CompanyCreate(
        name: 'My Awesome Company',
        email: 'company@example.com',
      ),
    );
    print('Company created: ${company.name}');
  } catch (e) {
    print('An error occurred: $e');
  }
}
