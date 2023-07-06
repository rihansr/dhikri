import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BaseBloc extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
