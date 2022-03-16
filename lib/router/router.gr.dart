// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;

import '../data/models/models.dart' as _i18;
import '../presentation/views/checkout_screen/bloc/bloc.dart' as _i19;
import '../presentation/views/checkout_screen/checkout_screen.dart' as _i4;
import '../presentation/views/checkout_screen/components/address_selection.dart'
    as _i6;
import '../presentation/views/home_page/home_screen.dart' as _i2;
import '../presentation/views/home_page/screens/cart_screen/cart_screen.dart'
    as _i10;
import '../presentation/views/home_page/screens/orders_screen/components.dart/order_details.dart'
    as _i5;
import '../presentation/views/home_page/screens/orders_screen/orders_screen.dart'
    as _i12;
import '../presentation/views/home_page/screens/products_screen/components/prod_details.dart'
    as _i3;
import '../presentation/views/home_page/screens/products_screen/products_screen.dart'
    as _i9;
import '../presentation/views/home_page/screens/profile_screen/profile_screen.dart'
    as _i11;
import '../presentation/views/login_screen/login_screen.dart' as _i1;
import '../presentation/views/order_success_screen/order_success_screen.dart'
    as _i7;
import '../presentation/views/registration_screen/customer_registration/customer_reg_screen.dart'
    as _i13;
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart'
    as _i14;
import '../presentation/views/registration_screen/registration_screen.dart'
    as _i8;
import 'router_guard.dart' as _i17;

class AppRouter extends _i15.RootStackRouter {
  AppRouter(
      {_i16.GlobalKey<_i16.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i17.RouteGuard routeGuard;

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginFormScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    HomeScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetails(
              key: args.key, loadedProduct: args.loadedProduct));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CheckOutScreen());
    },
    OrderDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsScreenRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.OrderDetailsScreen(key: args.key, order: args.order));
    },
    AddressSelectionScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddressSelectionScreenRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.AddressSelectionScreen(
              key: args.key,
              checkoutBloc: args.checkoutBloc,
              onSelected: args.onSelected,
              deliveryMethod: args.deliveryMethod));
    },
    OrderSuccessScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderSuccessScreenRouteArgs>();
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.OrderSuccessScreen(key: args.key, message: args.message));
    },
    RegistrationScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.RegistrationScreen());
    },
    ProductsScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ProductsScreen());
    },
    CartScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CartScreen());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProfileScreen());
    },
    OrdersScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.OrdersScreen());
    },
    CustomerRegistrationScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.CustomerRegistrationScreen());
    },
    KaPartnerRegistrationScreenRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i14.KaPartnerRegistrationScreen());
    }
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(LoginRoute.name, path: '/login'),
        _i15.RouteConfig(HomeScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i15.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'products',
              fullMatch: true),
          _i15.RouteConfig(ProductsScreenRoute.name,
              path: 'products', parent: HomeScreenRoute.name),
          _i15.RouteConfig(CartScreenRoute.name,
              path: 'cart', parent: HomeScreenRoute.name),
          _i15.RouteConfig(ProfileScreenRoute.name,
              path: 'profile', parent: HomeScreenRoute.name),
          _i15.RouteConfig(OrdersScreenRoute.name,
              path: 'orders', parent: HomeScreenRoute.name)
        ]),
        _i15.RouteConfig(ProductDetailsRoute.name,
            path: '/productDetails', guards: [routeGuard]),
        _i15.RouteConfig(CheckOutScreenRoute.name,
            path: '/checkout', guards: [routeGuard]),
        _i15.RouteConfig(OrderDetailsScreenRoute.name,
            path: '/orderDetails', guards: [routeGuard]),
        _i15.RouteConfig(AddressSelectionScreenRoute.name,
            path: '/addressSelection', guards: [routeGuard]),
        _i15.RouteConfig(OrderSuccessScreenRoute.name,
            path: '/orderSuccess', guards: [routeGuard]),
        _i15.RouteConfig(RegistrationScreenRoute.name,
            path: '/registration',
            children: [
              _i15.RouteConfig(CustomerRegistrationScreenRoute.name,
                  path: 'customer', parent: RegistrationScreenRoute.name),
              _i15.RouteConfig(KaPartnerRegistrationScreenRoute.name,
                  path: 'kapartner', parent: RegistrationScreenRoute.name)
            ])
      ];
}

/// generated route for
/// [_i1.LoginFormScreen]
class LoginRoute extends _i15.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i16.Key? key, dynamic Function(bool)? onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginCallback});

  final _i16.Key? key;

  final dynamic Function(bool)? onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i15.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.ProductDetails]
class ProductDetailsRoute extends _i15.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({_i16.Key? key, required _i18.ProductModel loadedProduct})
      : super(ProductDetailsRoute.name,
            path: '/productDetails',
            args: ProductDetailsRouteArgs(
                key: key, loadedProduct: loadedProduct));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.loadedProduct});

  final _i16.Key? key;

  final _i18.ProductModel loadedProduct;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, loadedProduct: $loadedProduct}';
  }
}

/// generated route for
/// [_i4.CheckOutScreen]
class CheckOutScreenRoute extends _i15.PageRouteInfo<void> {
  const CheckOutScreenRoute()
      : super(CheckOutScreenRoute.name, path: '/checkout');

  static const String name = 'CheckOutScreenRoute';
}

/// generated route for
/// [_i5.OrderDetailsScreen]
class OrderDetailsScreenRoute
    extends _i15.PageRouteInfo<OrderDetailsScreenRouteArgs> {
  OrderDetailsScreenRoute({_i16.Key? key, required _i18.OrderItemModel order})
      : super(OrderDetailsScreenRoute.name,
            path: '/orderDetails',
            args: OrderDetailsScreenRouteArgs(key: key, order: order));

  static const String name = 'OrderDetailsScreenRoute';
}

class OrderDetailsScreenRouteArgs {
  const OrderDetailsScreenRouteArgs({this.key, required this.order});

  final _i16.Key? key;

  final _i18.OrderItemModel order;

  @override
  String toString() {
    return 'OrderDetailsScreenRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i6.AddressSelectionScreen]
class AddressSelectionScreenRoute
    extends _i15.PageRouteInfo<AddressSelectionScreenRouteArgs> {
  AddressSelectionScreenRoute(
      {_i16.Key? key,
      required _i19.CheckoutFormBloc checkoutBloc,
      required void Function(_i18.CustomerAddressModel?) onSelected,
      required String deliveryMethod})
      : super(AddressSelectionScreenRoute.name,
            path: '/addressSelection',
            args: AddressSelectionScreenRouteArgs(
                key: key,
                checkoutBloc: checkoutBloc,
                onSelected: onSelected,
                deliveryMethod: deliveryMethod));

  static const String name = 'AddressSelectionScreenRoute';
}

class AddressSelectionScreenRouteArgs {
  const AddressSelectionScreenRouteArgs(
      {this.key,
      required this.checkoutBloc,
      required this.onSelected,
      required this.deliveryMethod});

  final _i16.Key? key;

  final _i19.CheckoutFormBloc checkoutBloc;

  final void Function(_i18.CustomerAddressModel?) onSelected;

  final String deliveryMethod;

  @override
  String toString() {
    return 'AddressSelectionScreenRouteArgs{key: $key, checkoutBloc: $checkoutBloc, onSelected: $onSelected, deliveryMethod: $deliveryMethod}';
  }
}

/// generated route for
/// [_i7.OrderSuccessScreen]
class OrderSuccessScreenRoute
    extends _i15.PageRouteInfo<OrderSuccessScreenRouteArgs> {
  OrderSuccessScreenRoute({_i16.Key? key, required String message})
      : super(OrderSuccessScreenRoute.name,
            path: '/orderSuccess',
            args: OrderSuccessScreenRouteArgs(key: key, message: message));

  static const String name = 'OrderSuccessScreenRoute';
}

class OrderSuccessScreenRouteArgs {
  const OrderSuccessScreenRouteArgs({this.key, required this.message});

  final _i16.Key? key;

  final String message;

  @override
  String toString() {
    return 'OrderSuccessScreenRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i8.RegistrationScreen]
class RegistrationScreenRoute extends _i15.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(RegistrationScreenRoute.name,
            path: '/registration', initialChildren: children);

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for
/// [_i9.ProductsScreen]
class ProductsScreenRoute extends _i15.PageRouteInfo<void> {
  const ProductsScreenRoute()
      : super(ProductsScreenRoute.name, path: 'products');

  static const String name = 'ProductsScreenRoute';
}

/// generated route for
/// [_i10.CartScreen]
class CartScreenRoute extends _i15.PageRouteInfo<void> {
  const CartScreenRoute() : super(CartScreenRoute.name, path: 'cart');

  static const String name = 'CartScreenRoute';
}

/// generated route for
/// [_i11.ProfileScreen]
class ProfileScreenRoute extends _i15.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'profile');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i12.OrdersScreen]
class OrdersScreenRoute extends _i15.PageRouteInfo<void> {
  const OrdersScreenRoute() : super(OrdersScreenRoute.name, path: 'orders');

  static const String name = 'OrdersScreenRoute';
}

/// generated route for
/// [_i13.CustomerRegistrationScreen]
class CustomerRegistrationScreenRoute extends _i15.PageRouteInfo<void> {
  const CustomerRegistrationScreenRoute()
      : super(CustomerRegistrationScreenRoute.name, path: 'customer');

  static const String name = 'CustomerRegistrationScreenRoute';
}

/// generated route for
/// [_i14.KaPartnerRegistrationScreen]
class KaPartnerRegistrationScreenRoute extends _i15.PageRouteInfo<void> {
  const KaPartnerRegistrationScreenRoute()
      : super(KaPartnerRegistrationScreenRoute.name, path: 'kapartner');

  static const String name = 'KaPartnerRegistrationScreenRoute';
}
