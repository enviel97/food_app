import 'dart:io';

import 'package:food_shop/dependencies/controller/base.controller.dart';
import 'package:food_shop/dependencies/repository/api_client.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:food_shop/helpers/widget_functions.dart';
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

  Future<Response> getUser(String id) async {
    return await client.getData(AppConstants.AUTH_GET_USER, params: [id]);
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
    final results = await local.setString(AppConstants.TOKEN, token);
    if (results) return;
    throw const ResponseError("Can't store to local");
  }

  Future<String?> checkAuth() async {
    final token = local.getString(AppConstants.TOKEN);
    if (token == null) return null;
    if (Jwt.isExpired(token)) return null;
    return token;
  }

  Future<bool> removeToken() async {
    try {
      await local.remove(AppConstants.TOKEN);
      return true;
    } catch (error) {
      showError('Unknown');
      return false;
    }
  }
}
