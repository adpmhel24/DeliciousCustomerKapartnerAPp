import 'package:kapartner_app/presentation/views/default_page/models/cart_item_model/cart_item_model.dart';

class CartItemsRepo {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => [..._cartItems];

  Future<void> addToCart(CartItemModel cartItem) async {
    await Future.delayed(const Duration(milliseconds: 300));
    int index = _cartItems.indexWhere((e) => e.id == cartItem.id);

    if (index < 0) {
      _cartItems.add(cartItem);
    } else {
      _cartItems[index].quantity += cartItem.quantity;
      _cartItems[index].total += cartItem.total;
    }
  }

  double get totalCart {
    double totalAmount = 0;
    for (var e in _cartItems) {
      totalAmount += e.total;
    }
    return totalAmount;
  }

  // Delete Item From The Cart
  void deleteFromCart(CartItemModel cartItem) {
    int index = _cartItems.indexWhere((e) => e.id == cartItem.id);
    _cartItems.removeAt(index);
  }

  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _cartItems.clear();
  }

  ///Singleton factory
  static final CartItemsRepo _instance = CartItemsRepo._internal();

  factory CartItemsRepo() {
    return _instance;
  }

  CartItemsRepo._internal();
}
