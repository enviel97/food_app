import 'package:get/get.dart';

class RouteHelper {
  const RouteHelper._();
  // Methods
  static Future<T?>? goTo<T>(String name, {dynamic arguments}) {
    return Get.toNamed(name, arguments: arguments);
  }

  static void goBack<T>({T? result, bool canPop = false}) {
    return Get.back(result: result, canPop: canPop);
  }

  static Future<T?>? replace<T>(String name, {dynamic arguments}) {
    return Get.offAndToNamed(name, arguments: arguments);
  }
}
