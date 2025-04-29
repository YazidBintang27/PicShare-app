import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _preferencesService;

  HomeProvider(this._apiService, this._preferencesService);

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  Future<void> getStoryList() async {
    final token = _preferencesService.token;

    try {
      _resultState = AppLoadingState();
      notifyListeners();

      final result = await _apiService.getStoryList(token);

      if (result.error) {
        debugPrint('Result: $result');
        _resultState = AppErrorState(error: result.message);
        notifyListeners();
      } else {
        debugPrint('Success');
        _resultState = AppLoadedState(response: result);
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('$e');
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }
}
