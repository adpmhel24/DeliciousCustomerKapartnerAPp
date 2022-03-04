import './repositories.dart';

class AppRepo {
  static final authRepository = AuthRepository();
  static final productsRepository = ProductsRepo();
  static final customerInfoRepo = CustomerInfoRepo();
  static final cartRepo = CartItemsRepo();
  static final orderRepository = OrderRepo();
  static final phLocationRepository = PhLocationRepo();
  // static final customerRepository = CustomerRepo();
  // static final salesTypeRepository = SalesTypeRepo();
  // static final discTypeRepository = DiscountTypeRepo();
  // static final customerTypeRepository = CustomerTypeRepo();
  // static final checkOutRepository = CheckOutRepo();

  Future<void> init() async {
    await productsRepository.fetchProducts();
    await customerInfoRepo.getCustomerInfo();
    // await customerRepository.fetchCustomerFromAPI();
    // await salesTypeRepository.fetchFromAPI();
    // await discTypeRepository.fetchDiscType();
    // await customerTypeRepository.fetchCustomerType();
    // await phLocationRepository.fetchProvinces();
  }
}
