# Userverse Dart Client

A Dart client for integrating with the Userverse platform.

This package provides a convenient way to interact with the Userverse API from your Dart or Flutter application. It supports user management, company management, roles, and more.

## Features

- User authentication (login)
- User management (create, read, update)
- Company management (create, read, update)
- Role management within companies
- User management within companies

## Getting started

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  userverse_dart_client: ^0.0.1 # Replace with the latest version
```

Then, run `dart pub get`.

## Usage

Here is a simple example of how to use the client:

```dart
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

    // 3. Get current user
    print('\\nGetting current user...');
    final user = await client.users.getMe(token: accessToken);
    print('Current user: ${user.email}');

    // 4. Create a company
    print('\\nCreating a company...');
    final company = await client.companies.createCompany(
      token: accessToken,
      companyCreate: CompanyCreate(
        name: 'My Awesome Company',
        email: 'company@example.com',
      ),
    );
    print('Company created: ${company.name}');

    // 5. Add a user to the company
    print('\\nAdding a user to the company...');
    await client.companyUsers.addUserToCompany(
      token: accessToken,
      companyId: company.id,
      companyUserAdd: CompanyUserAdd(email: 'new.user@example.com'),
    );
    print('User added to company');

  } catch (e) {
    print('An error occurred: $e');
  }
}
```

## API Services

The client is organized into services:

- `client.users`: Handles user-related operations.
- `client.companies`: Handles company-related operations (creating, reading, updating companies).
- `client.companyUsers`: Handles user management within a company.
- `client.companyRoles`: Handles role management within a company.

Each service provides methods that correspond to the API endpoints.

## Additional information

This package is under active development. For more information, please see the [repository](https://github.com/SoftwareVerse/userverse-dart-client).
