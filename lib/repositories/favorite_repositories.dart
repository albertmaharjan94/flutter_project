import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:n_baz/models/favorite_model.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class FavoriteRepository{
  CollectionReference<FavoriteModel> favoriteRef = FirebaseService.db.collection("favorites")
      .withConverter<FavoriteModel>(
    fromFirestore: (snapshot, _) {
      return FavoriteModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
  Future<List<QueryDocumentSnapshot<FavoriteModel>>> getFavorites(String productId, String userId) async {
    try {
      var data = await favoriteRef.where("user_id", isEqualTo: userId).where("product_id", isEqualTo: productId).get();
      var favorites = data.docs;
      return favorites;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<FavoriteModel>>> getFavoritesUser(String userId) async {
    try {
      var data = await favoriteRef.where("user_id", isEqualTo: userId).get();
      var favorites = data.docs;
      return favorites;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> favorite(FavoriteModel? isFavorite, String productId, String userId)  async{
    try {
      if(isFavorite==null){
        await favoriteRef.add(FavoriteModel(userId: userId, productId: productId));
      }else{
        await favoriteRef.doc(isFavorite.id).delete();
      }
      return true;
    } catch (err) {
      rethrow;
    }
  }

}