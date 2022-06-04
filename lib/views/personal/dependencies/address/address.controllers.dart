import 'package:food_shop/dependencies/controller/base.controller.dart';
import 'package:food_shop/models/address.dart';
import 'package:food_shop/views/personal/dependencies/google_map/google_map.controller.dart';
import 'address.repository.dart';

class AddressController extends ApiControllerBase {
  final AddressRepo repo;
  late MapController cameraController;

  final List<Address> _addresses = [];
  List<Address> get addresses => _addresses;

  AddressController({required this.repo}) {
    cameraController = MapController();
  }
}
