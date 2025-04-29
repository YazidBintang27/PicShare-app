import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService _apiService;

  final SharedPreferencesService _preferencesService;

  DetailProvider(this._apiService, this._preferencesService);

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  Future<void> getStoryDetail(String id) async {
    final token = _preferencesService.token;

    try {
      _resultState = AppLoadingState();
      notifyListeners();

      final result = await _apiService.getStoryDetail(id, token);
      
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
}
