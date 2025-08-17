import 'package:userverse_dart_client/userverse_dart_client.dart';

void main() async {
  // 1. Create a client
  final client = UserverseClient();

  try {
    // 2. Login
    print('Logging in...');
    final response = await client.users.login(
      email: 'YOUR_USERNAME', // Replace with your username
      password: 'YOUR_PASSWORD', // Replace with your password
    );
    final accessToken = response.success;
    print('Logged in successfully!');
    print('Access token: $accessToken');


  } catch (e) {
    print('An error occurred: $e');
  }
}
