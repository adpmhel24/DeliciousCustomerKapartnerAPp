// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../presentation/views/login_screen/login_screen.dart' as _i1;
import '../presentation/views/order_screen/orders_screen.dart' as _i2;
import '../presentation/views/select_reg_type_screen/registration_type_screen.dart'
    as _i3;
import 'router_guard.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i6.RouteGuard routeGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginFormScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    OrderScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.OrderScreen());
    },
    RegistrationTypeScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegistrationTypeScreen());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(LoginRoute.name, path: '/login'),
        _i4.RouteConfig(OrderScreenRoute.name, path: '/', guards: [routeGuard]),
        _i4.RouteConfig(RegistrationTypeScreenRoute.name,
            path: '/type_of_registration')
      ];
}

/// generated route for
/// [_i1.LoginFormScreen]
class LoginRoute extends _i4.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i5.Key? key, dynamic Function(bool)? onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginCallback});

  final _i5.Key? key;

  final dynamic Function(bool)? onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.OrderScreen]
class OrderScreenRoute extends _i4.PageRouteInfo<void> {
  const OrderScreenRoute() : super(OrderScreenRoute.name, path: '/');

  static const String name = 'OrderScreenRoute';
}

/// generated route for
/// [_i3.RegistrationTypeScreen]
class RegistrationTypeScreenRoute extends _i4.PageRouteInfo<void> {
  const RegistrationTypeScreenRoute()
      : super(RegistrationTypeScreenRoute.name, path: '/type_of_registration');

  static const String name = 'RegistrationTypeScreenRoute';
}
