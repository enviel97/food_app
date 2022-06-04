part of '../routes.dart';

class RouteId {
  const RouteId._();
  static String getHome() => _home;
  static String getMain() => _main;
  static String getSplash() => _splash;
  static String getSignIn() => _signin;
  static String getSignUp() => _signup;
  // route need param
  static String getForgotPassword(String initEmail) =>
      '$_signin$_forgotPassword?initEmail=$initEmail';
  static String getPopularFood(String foodId) =>
      '/home$_popular?foodId=$foodId';
  static String getRecommendedFood(String foodId) =>
      '/home$_recommended?foodId=$foodId';
  static String getCart({String? cartId}) =>
      _cart + ((cartId?.isEmpty ?? true) ? '' : '?cartId=$cartId');
  static String getAddress({double? longitude, double? latitude}) =>
      '$_address?longitude=${longitude ?? ''}&latitude=${longitude ?? ''}';
}
