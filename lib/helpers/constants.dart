// ignore_for_file: constant_identifier_names

class AppConstants {
  const AppConstants();

  // app
  static const APP_NAME = 'DBFood';
  static const APP_VERSION = 0;
  static const API_KEY = 'b2163edd494d5227bcccf66e84f23ef5';

  // rest api
  static const BASE_URL =
      'http://192.168.27.27:3000'; //'https://be-food-app.herokuapp.com';
  static const POPULAR_PRODUCT_URI = '/food/get/common';
  static const RECOMMENDED_PRODUCT_URI = '/food/get/popular';
  static const GET_PRODUCT = '/food/get';

  // local key
  static const CART_HISTORY = 'cart_ids';
  static const CART_TEMP = 'cart_temp';
}
