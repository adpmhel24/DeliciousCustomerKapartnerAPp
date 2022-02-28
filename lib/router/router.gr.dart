// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../data/models/models.dart' as _i14;
import '../presentation/views/checkout_screen/checkout_screen.dart' as _i4;
import '../presentation/views/default_page/default_screen.dart' as _i2;
import '../presentation/views/default_page/screens/cart_screen/cart_screen.dart'
    as _i7;
import '../presentation/views/default_page/screens/products_screen/components/prod_details.dart'
    as _i3;
import '../presentation/views/default_page/screens/products_screen/products_screen.dart'
    as _i6;
import '../presentation/views/default_page/screens/profile_screen/profile_screen.dart'
    as _i8;
import '../presentation/views/login_screen/login_screen.dart' as _i1;
import '../presentation/views/registration_screen/customer_registration/customer_reg_screen.dart'
    as _i9;
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart'
    as _i10;
import '../presentation/views/registration_screen/registration_screen.dart'
    as _i5;
import 'router_guard.dart' as _i13;

class AppRouter extends _i11.RootStackRouter {
  AppRouter(
      {_i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i13.RouteGuard routeGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginFormScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    HomeScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetails(
              key: args.key, loadedProduct: args.loadedProduct));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CheckOutScreen());
    },
    RegistrationScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.RegistrationScreen());
    },
    ProductsScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProductsScreen());
    },
    CartScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.CartScreen());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ProfileScreen());
    },
    CustomerRegistrationScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.CustomerRegistrationScreen());
    },
    KaPartnerRegistrationScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i10.KaPartnerRegistrationScreen());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(LoginRoute.name, path: '/login'),
        _i11.RouteConfig(HomeScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i11.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'products',
              fullMatch: true),
          _i11.RouteConfig(ProductsScreenRoute.name,
              path: 'products', parent: HomeScreenRoute.name),
          _i11.RouteConfig(CartScreenRoute.name,
              path: 'cart', parent: HomeScreenRoute.name),
          _i11.RouteConfig(ProfileScreenRoute.name,
              path: 'profile', parent: HomeScreenRoute.name)
        ]),
        _i11.RouteConfig(ProductDetailsRoute.name,
            path: '/productDetails', guards: [routeGuard]),
        _i11.RouteConfig(CheckOutScreenRoute.name,
            path: '/checkout', guards: [routeGuard]),
        _i11.RouteConfig(RegistrationScreenRoute.name,
            path: '/registration',
            children: [
              _i11.RouteConfig(CustomerRegistrationScreenRoute.name,
                  path: 'customer', parent: RegistrationScreenRoute.name),
              _i11.RouteConfig(KaPartnerRegistrationScreenRoute.name,
                  path: 'kapartner', parent: RegistrationScreenRoute.name)
            ])
      ];
}

/// generated route for
/// [_i1.LoginFormScreen]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i12.Key? key, dynamic Function(bool)? onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginCallback});

  final _i12.Key? key;

  final dynamic Function(bool)? onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i11.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i11.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.ProductDetails]
class ProductDetailsRoute extends _i11.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({_i12.Key? key, required _i14.ProductModel loadedProduct})
      : super(ProductDetailsRoute.name,
            path: '/productDetails',
            args: ProductDetailsRouteArgs(
                key: key, loadedProduct: loadedProduct));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.loadedProduct});

  final _i12.Key? key;

  final _i14.ProductModel loadedProduct;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, loadedProduct: $loadedProduct}';
  }
}

/// generated route for
/// [_i4.CheckOutScreen]
class CheckOutScreenRoute extends _i11.PageRouteInfo<void> {
  const CheckOutScreenRoute()
      : super(CheckOutScreenRoute.name, path: '/checkout');

  static const String name = 'CheckOutScreenRoute';
}

/// generated route for
/// [_i5.RegistrationScreen]
class RegistrationScreenRoute extends _i11.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i11.PageRouteInfo>? children})
      : super(RegistrationScreenRoute.name,
            path: '/registration', initialChildren: children);

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for
/// [_i6.ProductsScreen]
class ProductsScreenRoute extends _i11.PageRouteInfo<void> {
  const ProductsScreenRoute()
      : super(ProductsScreenRoute.name, path: 'products');

  static const String name = 'ProductsScreenRoute';
}

/// generated route for
/// [_i7.CartScreen]
class CartScreenRoute extends _i11.PageRouteInfo<void> {
  const CartScreenRoute() : super(CartScreenRoute.name, path: 'cart');

  static const String name = 'CartScreenRoute';
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileScreenRoute extends _i11.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'profile');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i9.CustomerRegistrationScreen]
class CustomerRegistrationScreenRoute extends _i11.PageRouteInfo<void> {
  const CustomerRegistrationScreenRoute()
      : super(CustomerRegistrationScreenRoute.name, path: 'customer');

  static const String name = 'CustomerRegistrationScreenRoute';
}

/// generated route for
/// [_i10.KaPartnerRegistrationScreen]
class KaPartnerRegistrationScreenRoute extends _i11.PageRouteInfo<void> {
  const KaPartnerRegistrationScreenRoute()
      : super(KaPartnerRegistrationScreenRoute.name, path: 'kapartner');

  static const String name = 'KaPartnerRegistrationScreenRoute';
}
