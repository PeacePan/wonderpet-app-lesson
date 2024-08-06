import 'package:flutter/material.dart';

class ExampleProvider with ChangeNotifier {
  String _title = '';

  String get title => _title;

  void setExample(String value) {
    _title = value;
    notifyListeners();
  }
}
