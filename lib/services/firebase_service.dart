import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService{
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore db = FirebaseFirestore.instance;

}