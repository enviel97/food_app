import 'dart:io';

import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/repository/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthRepo extends GetxService {
  final ApiClient client;
  final SharedPreferences local;

  AuthRepo({required this.client, required this.local});

  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    return await client.postData(AppConstants.AUTH_SIGNIN, body: {
      'email': email,
      'password': password,
    });
  }

  Future<Response> signUp({
    required String email,
    required String password,
    required String birth,
    required String gender,
    required String name,
    File? avatar,
  }) async {
    return await client.postDataWithMedia(
      AppConstants.AUTH_SIGNUP,
      body: {
        'email': email,
        'password': password,
        'birth': birth,
        'gender': gender,
        'name': name,
      },
      files: avatar != null ? {'avatar': avatar} : null,
    );
  }

  Future<Response> verify(String email) async {
    return await client.postData(
      AppConstants.AUTH_VERIFY,
      body: {'email': email},
    );
  }

  Future<Response> changePassword(String email, String password) async {
    return await client.postData(
      AppConstants.AUTH_CHANGE_PASSWORD,
      body: {'email': email, 'password': password},
    );
  }

  Future<void> storeToken({required String id, required String token}) async {
    final results = await Future.wait([
      local.setString(AppConstants.TOKEN, token),
      local.setString(token, id),
    ]);
    if (results[0] && results[1]) return;
    throw Exception("Can't store to local");
  }

  Future<bool> checkAuth() async {
    final token = local.getString(AppConstants.TOKEN);
    if (token == null) return false;
    if (Jwt.isExpired(token)) return false;
    return true;
  }

  Future<bool> removeToken() async {
    final token = local.getString(AppConstants.TOKEN);
    if (token != null) {
      await Future.wait([
        local.remove(AppConstants.TOKEN),
        local.remove(token),
      ]);
      return true;
    }
    return false;
  }
}
