import 'package:flutter/material.dart';
import 'package:picshare_app/data/remote/models/request/register_request.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService _apiService;

  RegisterProvider(this._apiService);

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  bool _isPasswordHidden = false;

  void passwordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  bool get isPasswordHidden => _isPasswordHidden;

  Future<void> register(String name, String email, String password) async {
    RegisterRequest data =
        RegisterRequest(name: name, email: email, password: password);
    try {
      _resultState = AppLoadingState();
      notifyListeners();

      final result = await _apiService.register(data);

      if (result.error) {
        _resultState = AppErrorState(error: result.message);
        notifyListeners();
      } else {
        _resultState = AppLoadedState(response: result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }

  void resetState() {
    _resultState = AppNoneState();
    notifyListeners();
  }
}
