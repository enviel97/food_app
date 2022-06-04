// ignore_for_file: constant_identifier_names

class AppConstants {
  const AppConstants();

  /// [APP CONSTANTS]
  static const APP_NAME = 'DBFood';
  static const APP_VERSION = 0;
  static const API_KEY = 'b2163edd494d5227bcccf66e84f23ef5';

  /// [Local key]
  static const CART_TEMP = 'cart_temp';
  static const TOKEN = 'token';
  static const ID = 'token';
  static const CART_HISTORY = '';

  /// [BASIC SERVER]
  /// [https://be-food-app.herokuapp.com - clound host];
  /// [http://192.168.27.27:3000 - local host];
  static const BASE_URL = 'https://be-food-app.herokuapp.com';
  static const PHOTOS = '$BASE_URL/photos';

  /// [FOOD ROUTE]
  static const POPULAR_PRODUCT_URI = '/food/get/common';
  static const RECOMMENDED_PRODUCT_URI = '/food/get/popular';
  static const GET_PRODUCT = '/food/get';

  /// [AUTH ROUTE]
  static const AUTH_SIGNIN = '/user/signin';
  static const AUTH_SIGNUP = '/user/create';
  static const AUTH_VERIFY = '/user/verify';
  static const AUTH_CHANGE_PASSWORD = '/user/change_passord';
  static const AUTH_GET_USER = '/user/get';
}
