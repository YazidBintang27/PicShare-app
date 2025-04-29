import 'package:flutter/material.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';

class SplashProvider extends ChangeNotifier {
  final SharedPreferencesService _preferencesService;

  SplashProvider(this._preferencesService);

  String get token => _preferencesService.token;
}
