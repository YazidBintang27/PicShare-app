import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/models/request/login_request.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _preferencesService;

  LoginProvider(this._apiService, this._preferencesService);

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  bool _isPasswordHidden = false;

  void passwordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  bool get isPasswordHidden => _isPasswordHidden;

  Future<void> login(String email, String password) async {
    try {
      LoginRequest data = LoginRequest(email: email, password: password);
      _resultState = AppLoadingState();
      notifyListeners();

      final result = await _apiService.login(data);

      if (result.error) {
        _resultState = AppErrorState(error: result.message);
        notifyListeners();
      } else {
        await _preferencesService.saveToken(result.loginResult.token);
        await _preferencesService.saveLoginResponse(result);

        _resultState = AppLoadedState(response: result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }
}
