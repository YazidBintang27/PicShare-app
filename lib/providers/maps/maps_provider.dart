import 'package:flutter/foundation.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';

class MapsProvider extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _sharedPreferencesService;

  AppState _resultState = AppNoneState();
  AppState get resultState => _resultState;

  MapsProvider(this._apiService, this._sharedPreferencesService);

  Future<void> getStoryListWithLocation() async {
    try {
      final token = _sharedPreferencesService.token;
      _resultState = AppLoadingState();
      notifyListeners();

      final result = await _apiService.getStoryList(token, location: 1);

      if (result.error) {
        _resultState = AppErrorState(error: result.message);
        notifyListeners();
      } else {
        _resultState = AppLoadedState(response: result);
        notifyListeners();
      }
    } catch (e) {
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }
}
