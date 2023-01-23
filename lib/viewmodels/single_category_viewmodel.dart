import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_baz/models/category_model.dart';
import 'package:n_baz/models/product_model.dart';
import 'package:n_baz/models/user_model.dart';
import 'package:n_baz/repositories/auth_repositories.dart';
import 'package:n_baz/services/firebase_service.dart';
import 'package:n_baz/viewmodels/global_ui_viewmodel.dart';

import '../repositories/category_repositories.dart';
import '../repositories/product_repositories.dart';

class SingleCategoryViewModel with ChangeNotifier {
  CategoryRepository _categoryRepository = CategoryRepository();
  ProductRepository _productRepository = ProductRepository();
  CategoryModel? _category = CategoryModel();
  CategoryModel? get category => _category;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProductByCategory(String categoryId) async{
    _category=CategoryModel();
    _products=[];
    notifyListeners();
    try{
      print(categoryId);
      var response = await _categoryRepository.getCategory(categoryId);
      _category = response.data();
      var productResponse = await _productRepository.getProductByCategory(categoryId);
      for (var element in productResponse) {
        _products.add(element.data());
      }

      notifyListeners();
    }catch(e){
      _category = null;
      notifyListeners();
    }
  }

}
