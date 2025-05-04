import 'dart:convert';
import '../../model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Private static instance of the UserService
  static final AuthService _instance = AuthService._internal();

  // Private constructor to prevent external instantiation
  AuthService._internal();

  // Public factory constructor to return the same instance
  factory AuthService() {
    return _instance;
  }

  final String baseUrl = 'http://10.0.2.2:8000/api';

  // Get all users
  Future<List<UserModel>> getAllUsers() async {
    try {
      String path = "$baseUrl/users";
      final response = await http.get(Uri.parse(path));

      if (response.statusCode == 200) {
        // Parse the JSON response and convert it to a list of User objects
        List<dynamic> data = json.decode(response.body);
        print("responseData :: ${data}");
        return data.map((user) => UserModel.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<UserModel?> login({required String email, required String pwd}) async {
    try {
      final String path = "$baseUrl/login";
      final response = await http.post(
        Uri.parse(path),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": pwd}),
      );

      print("statusCode :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print("Login Success :: $data");
        print('status :: ${data['status']}');

        if (data['status'] == true) {
          print("save Data");
          return UserModel.fromJson(data['user']);
        } else {
          return null;
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        print("Server error :: ${errorData['message'] ?? 'Unknown error'}");
        return null;
      }
    } catch (e) {
      print("Exception :: $e");
      return null;
    }
  }
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      print("Registration Success: ${response.body}");
      return true;
    } else {
      print("Registration Failed: ${response.body}");
      return false;
    }
  }
}




