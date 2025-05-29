import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picshare_app/data/local/shared_preferences_service.dart';
import 'package:picshare_app/data/remote/models/request/add_story_request.dart';
import 'package:picshare_app/data/remote/services/api_service.dart';
import 'package:picshare_app/utils/app_state.dart';
import 'package:image/image.dart' as img;

class AddPictureProvider extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _preferencesService;

  AddPictureProvider(this._apiService, this._preferencesService);

  AppState _resultState = AppNoneState();

  AppState get resultState => _resultState;

  String? imagePath;
  XFile? imageFile;

  bool _isAddLocation = false;

  bool get isAddLocation => _isAddLocation;

  void setAddLocation(bool value) {
    _isAddLocation = value;
    notifyListeners();
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<void> addStory(AddStoryRequest data) async {
    final String token = _preferencesService.token;
    try {
      _resultState = AppLoadingState();
      notifyListeners();

      final response = await _apiService.addStory(data, token);

      if (response.error) {
        _resultState = AppErrorState(error: response.message);
        notifyListeners();
      } else {
        _resultState = AppLoadedState(response: response);
        notifyListeners();
      }
    } catch (e) {
      _resultState = AppErrorState(error: e.toString());
      notifyListeners();
    }
  }

  Future<File> compressImage(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();

    if (bytes.length < 1000000) return File(imageFile.path);

    final img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception("Failed to decode image");

    int compressQuality = 100;
    List<int> newBytes = [];

    do {
      compressQuality -= 10;
      newBytes = img.encodeJpg(image, quality: compressQuality);
    } while (newBytes.length > 1000000 && compressQuality > 10);

    final tempDir = await getTemporaryDirectory();
    final compressedFile = File(
        '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await compressedFile.writeAsBytes(newBytes);

    return compressedFile;
  }

  Future<File> resizeImage(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();

    // Jika ukuran sudah kecil, langsung return sebagai File asli
    if (bytes.length < 1000000) return File(imageFile.path);

    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) throw Exception("Failed to decode image");

    final isLandscape = originalImage.width > originalImage.height;
    final int maxSide =
        isLandscape ? originalImage.width : originalImage.height;

    double scale = 1.0;
    List<int> resizedBytes = bytes;

    do {
      scale -= 0.1;

      final resizedImage = img.copyResize(
        originalImage,
        width: isLandscape ? (maxSide * scale).toInt() : null,
        height: !isLandscape ? (maxSide * scale).toInt() : null,
      );

      resizedBytes = img.encodeJpg(resizedImage, quality: 100);
    } while (resizedBytes.length > 1000000 && scale > 0.1);

    final tempDir = await getTemporaryDirectory();
    final resizedFile = File(
        '${tempDir.path}/resized_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await resizedFile.writeAsBytes(resizedBytes);

    return resizedFile;
  }
}
