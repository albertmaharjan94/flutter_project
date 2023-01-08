import 'package:flutter/cupertino.dart';

class GlobalUIViewModel with ChangeNotifier{
  bool _isLoading = false;
  bool  get isLoading =>_isLoading;

  loadState(bool _state){
    _isLoading = _state;
    notifyListeners();
  }

}