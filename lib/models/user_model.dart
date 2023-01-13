// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.id,
    this.userId,
    this.name,
    this.username,
    this.phone,
    this.imageUrl,
    this.imagePath,
    this.fcm,
    this.email,
    this.password,
  });

  String? id;
  String? userId;
  String? name;
  String? username;
  String? phone;
  String? imageUrl;
  String? imagePath;
  String? fcm;
  String? email;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        username: json["username"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        imagePath: json["imagePath"],
        fcm: json["fcm"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "username": username,
        "phone": phone,
        "imageUrl": imageUrl,
        "imagePath": imagePath,
        "fcm": fcm,
        "email": email,
        "password": password,
      };
  factory UserModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => UserModel(
        id: json.id,
        userId: json["user_id"],
        name: json["name"],
        username: json["username"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        imagePath: json["imagePath"],
        fcm: json["fcm"],
        email: json["email"],
        password: json["password"],
      );

}
