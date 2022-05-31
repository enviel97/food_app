import 'package:food_shop/models/cart.dart';
import 'package:food_shop/views/history/dependencies/history.repository.dart';
import 'package:food_shop/widgets/dialogs/confirm_dialog.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final HistoryRepo repo;

  List<Cart> _carts = [];

  HistoryController({required this.repo});

  List<Cart> get carts => _carts;

  Future<void> getHistoryCart() async {
    _carts = repo.getHistory();
  }

  Future<void> removeCart(String id) async {
    if (await showConfirmDialog(
      title: 'Remove Cart',
      content: const BodyText('You want to remove this cart'),
    )) {
      _carts = _carts.where((cart) => cart.id != id).toList();
      repo.remove(id);
      update();
    }
  }

  Future<void> clear() async {}
}
