import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../sevice/authService/auth.dart';

class AuthProvider with ChangeNotifier{
  bool isLogin = false;
  bool isLoading = false;
  List<UserModel> userList = [];
UserModel? _userModel;
  String get userName => _userModel?.name ?? '';

  // ✅ Get user email
  String get userEmail => _userModel?.email ?? '';

  // The method to get all users
  Future<void> getAllUsers() async {
    isLoading = true;  // Set loading state to true while fetching
    notifyListeners(); // Notify listeners to rebuild UI (e.g., show a loading indicator)

    try {
      // Fetch the users using the UserService singleton
      userList = await AuthService().getAllUsers();
    } catch (e) {
      // Handle error if fetching users fails
      print("Error fetching users: $e");
    } finally {
      isLoading = false; // Set loading state to false after fetching
      notifyListeners(); // Notify listeners to rebuild UI (e.g., show users)
    }
  }
  Future<bool> login({required String email, required String pwd}) async {
    UserModel? userModel = await AuthService().login(email: email, pwd: pwd);

    if (userModel != null) {
      _userModel = userModel;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
  void logout() {
    _userModel = null;
    notifyListeners();
  }
  Future<bool> register({required String name,required String email,required String pwd,required String con_pdw}) async {
    try {
      final success = await AuthService().register(
        name: name,
        email: email,
        password: pwd,
        passwordConfirmation: con_pdw,
      );
      if (success) {
        notifyListeners(); // Notify UI
        return true; // Registration successful
      }



    } catch (e) {
      notifyListeners();
      return false;

    }
      return false;

  }


}




