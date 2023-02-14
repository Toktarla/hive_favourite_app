import 'package:flutter/material.dart';
class StateController extends ChangeNotifier{
  int ?indexOfNoun;
  void someFunc(index){
    indexOfNoun = index;
    notifyListeners();
  }
}