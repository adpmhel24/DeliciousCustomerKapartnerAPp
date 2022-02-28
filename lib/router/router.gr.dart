// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../data/models/models.dart' as _i13;
import '../presentation/views/default_page/blocs/cart_bloc/bloc.dart' as _i14;
import '../presentation/views/default_page/default_screen.dart' as _i2;
import '../presentation/views/default_page/screens/cart_screen/cart_screen.dart'
    as _i6;
import '../presentation/views/default_page/screens/products_screen/components/prod_details.dart'
    as _i3;
import '../presentation/views/default_page/screens/products_screen/products_screen.dart'
    as _i5;
import '../presentation/views/default_page/screens/profile_screen/profile_screen.dart'
    as _i7;
import '../presentation/views/login_screen/login_screen.dart' as _i1;
import '../presentation/views/registration_screen/customer_registration/customer_reg_screen.dart'
    as _i8;
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart'
    as _i9;
import '../presentation/views/registration_screen/registration_screen.dart'
    as _i4;
import 'router_guard.dart' as _i12;

class AppRouter extends _i10.RootStackRouter {
  AppRouter(
      {_i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i12.RouteGuard routeGuard;

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginFormScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    HomeScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetails(
              key: args.key,
              loadedProduct: args.loadedProduct,
              cartBloc: args.cartBloc));
    },
    RegistrationScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegistrationScreen());
    },
    ProductsScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ProductsScreen());
    },
    CartScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.CartScreen());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProfileScreen());
    },
    CustomerRegistrationScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CustomerRegistrationScreen());
    },
    KaPartnerRegistrationScreenRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.KaPartnerRegistrationScreen());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(LoginRoute.name, path: '/login'),
        _i10.RouteConfig(HomeScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i10.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'products',
              fullMatch: true),
          _i10.RouteConfig(ProductsScreenRoute.name,
              path: 'products', parent: HomeScreenRoute.name),
          _i10.RouteConfig(CartScreenRoute.name,
              path: 'cart', parent: HomeScreenRoute.name),
          _i10.RouteConfig(ProfileScreenRoute.name,
              path: 'profile', parent: HomeScreenRoute.name)
        ]),
        _i10.RouteConfig(ProductDetailsRoute.name,
            path: '/productDetails', guards: [routeGuard]),
        _i10.RouteConfig(RegistrationScreenRoute.name,
            path: '/registration',
            children: [
              _i10.RouteConfig(CustomerRegistrationScreenRoute.name,
                  path: 'customer', parent: RegistrationScreenRoute.name),
              _i10.RouteConfig(KaPartnerRegistrationScreenRoute.name,
                  path: 'kapartner', parent: RegistrationScreenRoute.name)
            ])
      ];
}

/// generated route for
/// [_i1.LoginFormScreen]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i11.Key? key, dynamic Function(bool)? onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginCallback});

  final _i11.Key? key;

  final dynamic Function(bool)? onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i10.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.ProductDetails]
class ProductDetailsRoute extends _i10.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute(
      {_i11.Key? key,
      required _i13.ProductModel loadedProduct,
      required _i14.CartBloc cartBloc})
      : super(ProductDetailsRoute.name,
            path: '/productDetails',
            args: ProductDetailsRouteArgs(
                key: key, loadedProduct: loadedProduct, cartBloc: cartBloc));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs(
      {this.key, required this.loadedProduct, required this.cartBloc});

  final _i11.Key? key;

  final _i13.ProductModel loadedProduct;

  final _i14.CartBloc cartBloc;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, loadedProduct: $loadedProduct, cartBloc: $cartBloc}';
  }
}

/// generated route for
/// [_i4.RegistrationScreen]
class RegistrationScreenRoute extends _i10.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(RegistrationScreenRoute.name,
            path: '/registration', initialChildren: children);

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for
/// [_i5.ProductsScreen]
class ProductsScreenRoute extends _i10.PageRouteInfo<void> {
  const ProductsScreenRoute()
      : super(ProductsScreenRoute.name, path: 'products');

  static const String name = 'ProductsScreenRoute';
}

/// generated route for
/// [_i6.CartScreen]
class CartScreenRoute extends _i10.PageRouteInfo<void> {
  const CartScreenRoute() : super(CartScreenRoute.name, path: 'cart');

  static const String name = 'CartScreenRoute';
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileScreenRoute extends _i10.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'profile');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i8.CustomerRegistrationScreen]
class CustomerRegistrationScreenRoute extends _i10.PageRouteInfo<void> {
  const CustomerRegistrationScreenRoute()
      : super(CustomerRegistrationScreenRoute.name, path: 'customer');

  static const String name = 'CustomerRegistrationScreenRoute';
}

/// generated route for
/// [_i9.KaPartnerRegistrationScreen]
class KaPartnerRegistrationScreenRoute extends _i10.PageRouteInfo<void> {
  const KaPartnerRegistrationScreenRoute()
      : super(KaPartnerRegistrationScreenRoute.name, path: 'kapartner');

  static const String name = 'KaPartnerRegistrationScreenRoute';
}
