import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n_baz/models/product_model.dart';
class CartModel {

  CartModel({required this.items, required this.user_id});

  List<CartItem> items;
  String? id;
  String? user_id;

  factory CartModel.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data = doc.data()! as Map<String, dynamic>;
    data["id"] = doc.id;
    return CartModel.fromJson(data);
  }


  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    items: List<CartItem>.from(json["items"]!.map((x) => CartItem.fromJson(x))),
    user_id: json["user_id"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "user_id": user_id,
  };
}

class CartItem {
  ProductModel product;
  int quantity;

  factory CartItem.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data = doc.data()! as Map<String, dynamic>;
    data["id"] = doc.id;
    return CartItem.fromJson(data);
  }


  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    product: ProductModel.fromJson(json["product"]),
    quantity: json["quantity"],
  );

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "product": product.toJson(),
  };

}