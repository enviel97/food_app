import 'dart:io';

import 'package:food_shop/controller/base.controller.dart';
import 'package:food_shop/helpers/widget_functions.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/views/auth/repository/auth.repository.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Verify {
  final String message;
  final bool status;

  const Verify(this.message, this.status);

  factory Verify.fromJson(Map<String, dynamic> json) {
    return Verify(json['message'], json['status']);
  }
}

class AuthController extends ApiControllerBase {
  final AuthRepo repo;
  AuthController({required this.repo});

  // USer
  User? user;

  Future<void> getUser() async {
    final token = await repo.checkAuth();
    if (token?.isEmpty ?? true) return;
    final datas = Jwt.parseJwt(token!);
    final data = datas['data'];
    if (data != null) {
      try {
        final result = await request(() => repo.getUser(data));
        if (result != null) {
          final user = User.fromJson(result);
          this.user = user;
          update();
        }
      } on ResponseError catch (error) {
        showError(error.cause);
      }
    }
  }

  // sigin
  Future<void> signIn(String email, String password) async {
    try {
      final result = await request(
          () async => await repo.signIn(email: email, password: password));
      if (result != null) {
        final user = User.fromJson(result['user']);
        this.user = user;
        update();
        repo.storeToken(id: user.id, token: result['token']);
      }
    } on ResponseError catch (error) {
      showError(error.cause);
    }
  }

  // signup
  Future<bool> signUp({
    required String email,
    required String password,
    required DateTime birth,
    required String gender,
    required String name,
    File? avatar,
  }) async {
    try {
      final result = await request(() async => await repo.signUp(
            email: email,
            password: password,
            birth: birth.toIso8601String(),
            gender: gender,
            name: name,
            avatar: avatar,
          ));
      if (result != null) {
        showSuccess('Sign up success');
        return true;
      }
      return false;
    } on ResponseError catch (error) {
      showError(error.cause);
      return false;
    }
  }

  // verify email
  Future<Verify> verifyUsername(String email) async {
    try {
      final result = await request(() async => await repo.verify(email));
      if (result != null) {
        final status = Verify.fromJson(result);
        return status;
      }
      return const Verify("Can't verify this email", false);
    } on ResponseError catch (error) {
      final message = error.cause['message'] ?? 'Unknown';
      showError(error.cause);
      return Verify('$message', false);
    }
  }

  // change password
  Future<Verify> changePassword(String username, String newPassord) async {
    try {
      final result = await request(
          () async => await repo.changePassword(username, newPassord));
      if (result != null) {
        final verify = Verify.fromJson(result);
        await repo.removeToken();
        return verify;
      }
      return const Verify("Can't verify this email", false);
    } on ResponseError catch (error) {
      final message = error.cause['message'] ?? 'Unknown';
      showError(error.cause);
      return Verify('$message', false);
    }
  }

  // logout
  Future<void> signOut() async {
    try {
      final isRemove = await repo.removeToken();
      if (!isRemove) throw const ResponseError("Don't have token");

      // TODO: should be update when have store token server
      // This just a simulator function
      await Future.delayed(const Duration(seconds: 2), () {
        user = null;
        update();
      });
    } on ResponseError catch (error) {
      showError(error.cause);
    }
  }
}
