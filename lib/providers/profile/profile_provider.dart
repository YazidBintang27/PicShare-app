import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/models/response/login.dart';
import 'package:picshare_app/utils/app_state.dart';

class ProfileProvider extends ChangeNotifier {
  final SharedPreferencesService _preferencesService;

  ProfileProvider(this._preferencesService);

  String get token => _preferencesService.token;

  Login? get loginResponse => _preferencesService.loginResponse;

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  Future<void> logout() async {
    try {
      _resultState = AppLoadingState();
      notifyListeners();
      await _preferencesService.clearSession();

      _resultState = AppLoadedState(response: true);
      notifyListeners();
    } on Exception catch (e) {
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }
}
