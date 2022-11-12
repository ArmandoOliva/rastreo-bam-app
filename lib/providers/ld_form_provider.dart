import 'package:flutter/material.dart'
    show ChangeNotifier, GlobalKey, FormState;

class LDFromProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  int idMensajero = 0;
  String mensajero = '';
  String barra = '';

  bool _isDisabled = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isDisabled => _isDisabled;

  set isDisabled(bool value) {
    _isDisabled = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
