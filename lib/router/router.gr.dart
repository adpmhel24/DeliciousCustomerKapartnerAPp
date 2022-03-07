// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import '../data/models/models.dart' as _i17;
import '../presentation/views/checkout_screen/checkout_screen.dart' as _i4;
import '../presentation/views/home_page/default_screen.dart' as _i2;
import '../presentation/views/home_page/screens/cart_screen/cart_screen.dart'
    as _i9;
import '../presentation/views/home_page/screens/orders_screen/components.dart/order_details.dart'
    as _i5;
import '../presentation/views/home_page/screens/orders_screen/orders_screen.dart'
    as _i11;
import '../presentation/views/home_page/screens/products_screen/components/prod_details.dart'
    as _i3;
import '../presentation/views/home_page/screens/products_screen/products_screen.dart'
    as _i8;
import '../presentation/views/home_page/screens/profile_screen/profile_screen.dart'
    as _i10;
import '../presentation/views/login_screen/login_screen.dart' as _i1;
import '../presentation/views/order_success_screen/order_success_screen.dart'
    as _i6;
import '../presentation/views/registration_screen/customer_registration/customer_reg_screen.dart'
    as _i12;
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart'
    as _i13;
import '../presentation/views/registration_screen/registration_screen.dart'
    as _i7;
import 'router_guard.dart' as _i16;

class AppRouter extends _i14.RootStackRouter {
  AppRouter(
      {_i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i16.RouteGuard routeGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginFormScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    HomeScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetails(
              key: args.key, loadedProduct: args.loadedProduct));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CheckOutScreen());
    },
    OrderDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsScreenRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.OrderDetailsScreen(key: args.key, order: args.order));
    },
    OrderSuccessScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderSuccessScreenRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.OrderSuccessScreen(key: args.key, message: args.message));
    },
    RegistrationScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.RegistrationScreen());
    },
    ProductsScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ProductsScreen());
    },
    CartScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CartScreen());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.ProfileScreen());
    },
    OrdersScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.OrdersScreen());
    },
    CustomerRegistrationScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.CustomerRegistrationScreen());
    },
    KaPartnerRegistrationScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i13.KaPartnerRegistrationScreen());
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(LoginRoute.name, path: '/login'),
        _i14.RouteConfig(HomeScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i14.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'products',
              fullMatch: true),
          _i14.RouteConfig(ProductsScreenRoute.name,
              path: 'products', parent: HomeScreenRoute.name),
          _i14.RouteConfig(CartScreenRoute.name,
              path: 'cart', parent: HomeScreenRoute.name),
          _i14.RouteConfig(ProfileScreenRoute.name,
              path: 'profile', parent: HomeScreenRoute.name),
          _i14.RouteConfig(OrdersScreenRoute.name,
              path: 'orders', parent: HomeScreenRoute.name)
        ]),
        _i14.RouteConfig(ProductDetailsRoute.name,
            path: '/productDetails', guards: [routeGuard]),
        _i14.RouteConfig(CheckOutScreenRoute.name,
            path: '/checkout', guards: [routeGuard]),
        _i14.RouteConfig(OrderDetailsScreenRoute.name,
            path: '/orderDetails', guards: [routeGuard]),
        _i14.RouteConfig(OrderSuccessScreenRoute.name,
            path: '/orderSuccess', guards: [routeGuard]),
        _i14.RouteConfig(RegistrationScreenRoute.name,
            path: '/registration',
            children: [
              _i14.RouteConfig(CustomerRegistrationScreenRoute.name,
                  path: 'customer', parent: RegistrationScreenRoute.name),
              _i14.RouteConfig(KaPartnerRegistrationScreenRoute.name,
                  path: 'kapartner', parent: RegistrationScreenRoute.name)
            ])
      ];
}

/// generated route for
/// [_i1.LoginFormScreen]
class LoginRoute extends _i14.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i15.Key? key, dynamic Function(bool)? onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginCallback});

  final _i15.Key? key;

  final dynamic Function(bool)? onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i14.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i14.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.ProductDetails]
class ProductDetailsRoute extends _i14.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({_i15.Key? key, required _i17.ProductModel loadedProduct})
      : super(ProductDetailsRoute.name,
            path: '/productDetails',
            args: ProductDetailsRouteArgs(
                key: key, loadedProduct: loadedProduct));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.loadedProduct});

  final _i15.Key? key;

  final _i17.ProductModel loadedProduct;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, loadedProduct: $loadedProduct}';
  }
}

/// generated route for
/// [_i4.CheckOutScreen]
class CheckOutScreenRoute extends _i14.PageRouteInfo<void> {
  const CheckOutScreenRoute()
      : super(CheckOutScreenRoute.name, path: '/checkout');

  static const String name = 'CheckOutScreenRoute';
}

/// generated route for
/// [_i5.OrderDetailsScreen]
class OrderDetailsScreenRoute
    extends _i14.PageRouteInfo<OrderDetailsScreenRouteArgs> {
  OrderDetailsScreenRoute({_i15.Key? key, required _i17.OrderItemModel order})
      : super(OrderDetailsScreenRoute.name,
            path: '/orderDetails',
            args: OrderDetailsScreenRouteArgs(key: key, order: order));

  static const String name = 'OrderDetailsScreenRoute';
}

class OrderDetailsScreenRouteArgs {
  const OrderDetailsScreenRouteArgs({this.key, required this.order});

  final _i15.Key? key;

  final _i17.OrderItemModel order;

  @override
  String toString() {
    return 'OrderDetailsScreenRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i6.OrderSuccessScreen]
class OrderSuccessScreenRoute
    extends _i14.PageRouteInfo<OrderSuccessScreenRouteArgs> {
  OrderSuccessScreenRoute({_i15.Key? key, required String message})
      : super(OrderSuccessScreenRoute.name,
            path: '/orderSuccess',
            args: OrderSuccessScreenRouteArgs(key: key, message: message));

  static const String name = 'OrderSuccessScreenRoute';
}

class OrderSuccessScreenRouteArgs {
  const OrderSuccessScreenRouteArgs({this.key, required this.message});

  final _i15.Key? key;

  final String message;

  @override
  String toString() {
    return 'OrderSuccessScreenRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i7.RegistrationScreen]
class RegistrationScreenRoute extends _i14.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i14.PageRouteInfo>? children})
      : super(RegistrationScreenRoute.name,
            path: '/registration', initialChildren: children);

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for
/// [_i8.ProductsScreen]
class ProductsScreenRoute extends _i14.PageRouteInfo<void> {
  const ProductsScreenRoute()
      : super(ProductsScreenRoute.name, path: 'products');

  static const String name = 'ProductsScreenRoute';
}

/// generated route for
/// [_i9.CartScreen]
class CartScreenRoute extends _i14.PageRouteInfo<void> {
  const CartScreenRoute() : super(CartScreenRoute.name, path: 'cart');

  static const String name = 'CartScreenRoute';
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileScreenRoute extends _i14.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'profile');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i11.OrdersScreen]
class OrdersScreenRoute extends _i14.PageRouteInfo<void> {
  const OrdersScreenRoute() : super(OrdersScreenRoute.name, path: 'orders');

  static const String name = 'OrdersScreenRoute';
}

/// generated route for
/// [_i12.CustomerRegistrationScreen]
class CustomerRegistrationScreenRoute extends _i14.PageRouteInfo<void> {
  const CustomerRegistrationScreenRoute()
      : super(CustomerRegistrationScreenRoute.name, path: 'customer');

  static const String name = 'CustomerRegistrationScreenRoute';
}

/// generated route for
/// [_i13.KaPartnerRegistrationScreen]
class KaPartnerRegistrationScreenRoute extends _i14.PageRouteInfo<void> {
  const KaPartnerRegistrationScreenRoute()
      : super(KaPartnerRegistrationScreenRoute.name, path: 'kapartner');

  static const String name = 'KaPartnerRegistrationScreenRoute';
}
