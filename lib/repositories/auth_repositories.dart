import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/firebase_service.dart';

class AuthRepository{

  Future<UserCredential?> register(UserModel user) async {
    try {
      final response = await FirebaseService.db
          .collection('users')
          .where("username", isEqualTo: user.username!).get();
      if (response.size != 0)
        throw Exception("Username already exists");
      UserCredential _uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.id = _uc.user!.uid;
      user.fcm = "";
      // insert into firestore user table
      await FirebaseService.db.collection('users').add(user.toJson());
      return _uc;
    } catch (err) {
      rethrow;
    }
  }


  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential _uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _uc;
    } catch (err) {
      rethrow;
    }
  }


  Future<void> logout() async {
    try {
      await FirebaseService.firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}