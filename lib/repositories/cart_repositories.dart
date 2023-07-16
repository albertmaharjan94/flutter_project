import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class CartRepository {
  final instance = FirebaseService.db.collection("cart").withConverter(
    fromFirestore: (snapshot, _) {
      return CartModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (CartModel model, _) => model.toJson(),
  );

  Future<dynamic> addToCart(ProductModel data, int quantity) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      FirebaseAuth.instance.currentUser!.uid;
      try {
        final response = await instance
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        if (response.docs.isEmpty) {
          final CartModel _data =
          CartModel(user_id: uid, items: [CartItem(product: data, quantity: quantity)]);
          await instance.add(_data);
        } else {
          var cart = response.docs.single.data();
          var checkProduct = cart.items.indexWhere((element) => element.product.id == data.id);
          if (checkProduct == -1) {
            cart.items.add(CartItem(product: data, quantity: quantity));
            await instance.doc(response.docs.single.id).set(cart);
          } else {
            cart.items[checkProduct].quantity += quantity;
            await instance.doc(response.docs.single.id).set(cart);
          }
        }
      } catch (err) {
        rethrow;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<dynamic> removeFromCart(ProductModel data) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      FirebaseAuth.instance.currentUser!.uid;
      try {
        final response = await instance
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

        var cart = response.docs.single.data();
        var checkProduct = cart.items.indexWhere((element) => element.product.id == data.id);
        if (cart.items[checkProduct].quantity <= 1) {
          cart.items.removeAt(checkProduct);
          await instance.doc(response.docs.single.id).set(cart);
        } else {
          cart.items[checkProduct].quantity -= 1;
          await instance.doc(response.docs.single.id).set(cart);
        }
      } catch (err) {
        rethrow;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
  Future<dynamic> removeItemFromCart(ProductModel data) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      FirebaseAuth.instance.currentUser!.uid;
      try {
        final response = await instance
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

        var cart = response.docs.single.data();
        var checkProduct = cart.items.indexWhere((element) => element.product.id == data.id);
        cart.items.removeAt(checkProduct);
        await instance.doc(response.docs.single.id).set(cart);

      } catch (err) {
        rethrow;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<dynamic> getCart() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return;
      }
      FirebaseAuth.instance.currentUser!.uid;
      try {
        final response = await instance
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
        return response.docs.single.data();
      } catch (err) {
        rethrow;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
