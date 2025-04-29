import 'dart:async';

import 'package:dio/dio.dart';
import 'package:picshare_app/data/remote/models/request/add_story_request.dart';
import 'package:picshare_app/data/remote/models/request/login_request.dart';
import 'package:picshare_app/data/remote/models/request/register_request.dart';
import 'package:picshare_app/data/remote/models/response/add_story.dart';
import 'package:picshare_app/data/remote/models/response/login.dart';
import 'package:picshare_app/data/remote/models/response/register.dart';
import 'package:picshare_app/data/remote/models/response/story_detail.dart';
import 'package:picshare_app/data/remote/models/response/story_list.dart';
import 'package:picshare_app/utils/api_constant.dart';
import 'package:path/path.dart';

class ApiService {
  Dio dio = Dio();

  Future<StoryList> getStoryList(String token) async {
    try {
      final response = await dio
          .get('${ApiConstant.baseUrl}${ApiConstant.stories}',
              options: Options(headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              }, contentType: 'application/json'))
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection Time out'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        StoryList storyList = StoryList.fromJson(data);
        return storyList;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StoryDetail> getStoryDetail(String id, String token) async {
    try {
      final response = await dio
          .get('${ApiConstant.baseUrl}${ApiConstant.stories}/$id',
              options: Options(headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              }, contentType: 'application/json'))
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection Time out'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        StoryDetail storyDetail = StoryDetail.fromJson(data);
        return storyDetail;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Register> register(RegisterRequest register) async {
    try {
      final response = await dio
          .post('${ApiConstant.baseUrl}${ApiConstant.register}',
              options: Options(
                  headers: {'Accept': 'application/json'},
                  contentType: 'application/json'),
              data: register.toJson())
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection Time out'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        Register register = Register.fromJson(data);
        return register;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Login> login(LoginRequest login) async {
    try {
      final response = await dio
          .post('${ApiConstant.baseUrl}${ApiConstant.login}',
              options: Options(
                  headers: {'Accept': 'application/json'},
                  contentType: 'application/json'),
              data: login.toJson())
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection Time out'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        Login login = Login.fromJson(data);
        return login;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AddStory> addStory(AddStoryRequest story, String token) async {
    try {
      final formData = FormData.fromMap({
        'description': story.description,
        'photo': await MultipartFile.fromFile(
          story.photo.path,
          filename: basename(story.photo.path),
        ),
        if (story.lat != null) 'lat': story.lat.toString(),
        if (story.lon != null) 'lon': story.lon.toString(),
      });

      final response = await dio
          .post('${ApiConstant.baseUrl}${ApiConstant.stories}',
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token'
                },
                contentType: 'multipart/form-data',
              ),
              data: formData)
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection Time out'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        AddStory addStory = AddStory.fromJson(data);
        return addStory;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      rethrow;
    }
  }
}
