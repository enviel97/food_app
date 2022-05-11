// ignore_for_file: constant_identifier_names

class AppConstants {
  const AppConstants();

  // app
  static const APP_NAME = 'DBFood';
  static const APP_VERSION = 0;
  static const TOKEN = 'DBToken';

  // rest api
  static const BASE_URL = 'https://mvs.bslmeiyu.com';
  static const POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const RECOMMENDED_PRODUCT_URI = '/api/v1/products/recommended';

  // local key
  static const CART_HISTORY = 'cart_ids';
  static const CART_TEMP = 'cart_temp';
}
