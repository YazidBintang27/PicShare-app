import 'dart:convert';

import 'package:picshare_app/data/remote/models/response/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String keyToken = "TOKEN";
  static const String keyLoginResponse = "LOGIN_RESPONSE";

  Future<void> saveToken(String token) async {
    try {
      await _preferences.setString(keyToken, token);
    } catch (e) {
      throw Exception("Failed to save token");
    }
  }

  Future<void> saveLoginResponse(Login response) async {
    try {
      final jsonString = jsonEncode(response.toJson());
      await _preferences.setString(keyLoginResponse, jsonString);
    } catch (e) {
      throw Exception("Failed to save login response");
    }
  }

  String get token => _preferences.getString(keyToken) ?? "";

  Login? get loginResponse {
    final jsonString = _preferences.getString(keyLoginResponse);
    if (jsonString == null) return null;
    try {
      final jsonMap = jsonDecode(jsonString);
      return Login.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearSession() async {
    await _preferences.remove(keyToken);
    await _preferences.remove(keyLoginResponse);
  }
}
