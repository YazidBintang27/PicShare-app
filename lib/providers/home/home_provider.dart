import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/models/response/story.dart';
import 'package:picshare_app/data/remote/models/response/story_list.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _preferencesService;

  HomeProvider(this._apiService, this._preferencesService);

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  int? pageItems = 1;
  int sizeItems = 10;

  Future<void> getStoryList() async {
    final token = _preferencesService.token;

    try {
      if (pageItems == 1) {
        _resultState = AppLoadingState();
        notifyListeners();
      }

      final result = await _apiService.getStoryList(token,
          page: pageItems!, size: sizeItems);

      if (result.error) {
        debugPrint('Result: $result');
        _resultState = AppErrorState(error: result.message);
        notifyListeners();
      } else {
        debugPrint('Success');
        if (_resultState is AppLoadedState && pageItems != 1) {
          final previous =
              (_resultState as AppLoadedState).response as StoryList;
          final combinedList = List<Story>.from(previous.listStory)
            ..addAll(result.listStory);

          final combinedResult = StoryList(
            error: result.error,
            message: result.message,
            listStory: combinedList,
          );

          _resultState = AppLoadedState(response: combinedResult);
        } else {
          _resultState = AppLoadedState(response: result);
        }

        if (result.listStory.length < sizeItems) {
          pageItems = null;
        } else {
          pageItems = pageItems! + 1;
        }
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('$e');
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }
}
