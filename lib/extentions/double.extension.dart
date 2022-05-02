import 'package:food_shop/styles/dimensions.dart';

extension Reponsive on double {
  double get h => this * (Dimensions.kHeight / 781.1);
  double get w => this * (Dimensions.kWidth / 392.7);
}
