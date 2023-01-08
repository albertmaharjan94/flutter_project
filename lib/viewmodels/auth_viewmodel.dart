import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_baz/models/user_model.dart';
import 'package:n_baz/repositories/auth_repositories.dart';
import 'package:n_baz/services/firebase_service.dart';
import 'package:n_baz/viewmodels/global_ui_viewmodel.dart';

class AuthViewModel with ChangeNotifier {
  User? _user = FirebaseService.firebaseAuth.currentUser;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> register(UserModel user) async {
    try {
      var response = await AuthRepository().register(user);
      _user = response!.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async{
    try{
      await AuthRepository().logout();
      _user = null;
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }
}
