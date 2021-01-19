import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String tukytext = 'tukyですよ';
  void ChangeTukyText(){
    tukytext = 'tuky更新';
    notifyListeners();
  }
}
