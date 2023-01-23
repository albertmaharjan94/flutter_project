import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:n_baz/models/product_model.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class ProductRepository {
  CollectionReference<ProductModel> productRef = FirebaseService.db.collection("products").withConverter<ProductModel>(
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

  Future<List<QueryDocumentSnapshot<ProductModel>>> getProductByCategory(String id) async {
    try {
      final response = await productRef.where("category_id", isEqualTo: id.toString()).get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<ProductModel>>> getProductFromList(List<String> productIds) async {
    try {
      final response = await productRef.where(FieldPath.documentId, whereIn: productIds).get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<ProductModel>>> getMyProducts(String userId) async {
    try {
      final response = await productRef.where("user_id", isEqualTo: userId).get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }


  Future<bool> removeProduct(String productId, String userId) async {
    try {
      final response = await productRef.doc(productId).get();
      if(response.data()!.userId !=  userId){
        return false;
      }
      await productRef.doc(productId).delete();
      return true;
    } catch (err) {
      print(err);
      rethrow;
    }
  }



  Future<DocumentSnapshot<ProductModel>> getOneProduct(String id) async {
    try {
      final response = await productRef.doc(id).get();
      if (!response.exists) {
        throw Exception("Product doesnot exists");
      }
      return response;
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
    }
  }

  Future<bool?> editProduct({required ProductModel product, required String productId}) async {
    try {
      final response = await productRef.doc(productId).set(product);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool?> favorites({required ProductModel product}) async {
    try {
      final response = await productRef.add(product);
      return true;
    } catch (err) {
      return false;
      rethrow;
    }
  }
}
