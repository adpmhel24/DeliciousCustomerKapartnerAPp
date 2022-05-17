import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapartner_app/global_bloc/blocs.dart';

class GlobalBloc {
  static final authBloc = AuthBloc();
  static final cartBloc = CartBloc();
  static final customerInfoBloc = CustomerInfoBloc();
  static final productBloc = ProductsBloc();
  static final orderBloc = OrderBloc();
  // static final productsBloc = ProductsBloc();
  // static final customerBloc = CustomerBloc();
  // static final salesTypeBloc = SalesTypeBloc();
  // static final discTypeBloc = DiscTypeBloc();
  // static final custTypeBloc = CustTypeBloc();
  // static final provinceBloc = ProvinceBloc();
  static final cityMunicipalityBloc = CityMunicipalityBloc();
  static final brgyBloc = BrgyBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<CartBloc>(create: (context) => cartBloc),
    BlocProvider<CustomerInfoBloc>(create: (context) => customerInfoBloc),
    BlocProvider<CityMunicipalityBloc>(
        create: (context) => cityMunicipalityBloc),
    BlocProvider<BrgyBloc>(create: (context) => brgyBloc),
    BlocProvider<ProductsBloc>(create: (context) => productBloc),
    BlocProvider<ProductsBloc>(create: (context) => productBloc),
    BlocProvider<OrderBloc>(create: (context) => orderBloc),

    // BlocProvider<ProductsBloc>(create: (context) => productsBloc),
    // BlocProvider<CustomerBloc>(create: (context) => customerBloc),
    // BlocProvider<SalesTypeBloc>(create: (context) => salesTypeBloc),
    // BlocProvider<DiscTypeBloc>(create: (context) => discTypeBloc),
    // BlocProvider<CustTypeBloc>(create: (context) => custTypeBloc),
    // BlocProvider<ProvinceBloc>(create: (context) => provinceBloc),
  ];

  static void dispose() {
    authBloc.close();
    cartBloc.close();
    customerInfoBloc.close();
    productBloc.close();
    orderBloc.close();
    // productsBloc.close();
    // cartBloc.close();
    // customerBloc.close();
    // salesTypeBloc.close();
    // discTypeBloc.close();
    // custTypeBloc.close();
    // provinceBloc.close();
    // cityMunicipalityBloc.close();
    // brgyBloc.close();
  }

  /// Singleton factory
  static final GlobalBloc _instance = GlobalBloc._internal();

  factory GlobalBloc() {
    return _instance;
  }
  GlobalBloc._internal();
}
