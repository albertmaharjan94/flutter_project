import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:n_baz/models/product_model.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class ProductRepository{
  CollectionReference<ProductModel> productRef = FirebaseService.db.collection("products")
      .withConverter<ProductModel>(
    fromFirestore: (snapshot, _) {
      return ProductModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Future<List<QueryDocumentSnapshot<ProductModel>>> getAllProducts() async {
    try {
      final response = await productRef.get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }


  Future<bool?> addProducts({required ProductModel product}) async {
    try {
      final response = await productRef.add(product);
      return true;
    } catch (err) {
      return false;
      rethrow;
    }
  }


}