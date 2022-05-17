// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:io' as _i20;

import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:flutter_bloc/flutter_bloc.dart' as _i21;

import '../data/models/models.dart' as _i19;
import '../presentation/views/checkout_screen/bloc/bloc.dart' as _i22;
import '../presentation/views/checkout_screen/checkout_screen.dart' as _i4;
import '../presentation/views/checkout_screen/components/address_selection.dart'
    as _i7;
import '../presentation/views/checkout_screen/components/attachment_viewer.dart'
    as _i5;
import '../presentation/views/home_page/home_screen.dart' as _i2;
import '../presentation/views/home_page/screens/cart_screen/cart_screen.dart'
    as _i12;
import '../presentation/views/home_page/screens/orders_screen/order_details_screen/order_details_screen.dart'
    as _i6;
import '../presentation/views/home_page/screens/orders_screen/orders_screen.dart'
    as _i14;
import '../presentation/views/home_page/screens/products_screen/components/prod_details.dart'
    as _i3;
import '../presentation/views/home_page/screens/products_screen/products_screen.dart'
    as _i11;
import '../presentation/views/home_page/screens/profile_screen/profile_screen.dart'
    as _i13;
import '../presentation/views/login_screen/login_screen.dart' as _i1;
import '../presentation/views/order_success_screen/order_success_screen.dart'
    as _i8;
import '../presentation/views/registration_screen/customer_registration/customer_reg_screen.dart'
    as _i15;
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart'
    as _i16;
import '../presentation/views/registration_screen/registration_screen.dart'
    as _i10;
import '../presentation/widget/image_viewer.dart' as _i9;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginFormScreen());
    },
    HomeScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetails(
              key: args.key, loadedProduct: args.loadedProduct));
    },
    CheckOutScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CheckOutScreen());
    },
    AttachmentViewerRoute.name: (routeData) {
      final args = routeData.argsAs<AttachmentViewerRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.AttachmentViewer(
              key: args.key,
              imageFile: args.imageFile,
              onDelete: args.onDelete));
    },
    OrderDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsScreenRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.OrderDetailsScreen(
              key: args.key,
              order: args.order,
              orderTab: args.orderTab,
              bloc: args.bloc));
    },
    AddressSelectionScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddressSelectionScreenRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.AddressSelectionScreen(
              key: args.key,
              checkoutBloc: args.checkoutBloc,
              onSelected: args.onSelected,
              deliveryMethod: args.deliveryMethod));
    },
    OrderSuccessScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OrderSuccessScreenRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.OrderSuccessScreen(key: args.key, message: args.message));
    },
    ImageViewerRoute.name: (routeData) {
      final args = routeData.argsAs<ImageViewerRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.ImageViewer(
              key: args.key,
              initialIndex: args.initialIndex,
              attachments: args.attachments));
    },
    RegistrationScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.RegistrationScreen());
    },
    ProductsScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProductsScreen());
    },
    CartScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.CartScreen());
    },
    ProfileScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.ProfileScreen());
    },
    OrdersScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.OrdersScreen());
    },
    CustomerRegistrationScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.CustomerRegistrationScreen());
    },
    KaPartnerRegistrationScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i16.KaPartnerRegistrationScreen());
    }
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(LoginRoute.name, path: '/login'),
        _i17.RouteConfig(HomeScreenRoute.name, path: '/', children: [
          _i17.RouteConfig('#redirect',
              path: '',
              parent: HomeScreenRoute.name,
              redirectTo: 'products',
              fullMatch: true),
          _i17.RouteConfig(ProductsScreenRoute.name,
              path: 'products', parent: HomeScreenRoute.name),
          _i17.RouteConfig(CartScreenRoute.name,
              path: 'cart', parent: HomeScreenRoute.name),
          _i17.RouteConfig(ProfileScreenRoute.name,
              path: 'profile', parent: HomeScreenRoute.name),
          _i17.RouteConfig(OrdersScreenRoute.name,
              path: 'orders', parent: HomeScreenRoute.name)
        ]),
        _i17.RouteConfig(ProductDetailsRoute.name, path: '/productDetails'),
        _i17.RouteConfig(CheckOutScreenRoute.name, path: '/checkout'),
        _i17.RouteConfig(AttachmentViewerRoute.name, path: 'attachmentViewer'),
        _i17.RouteConfig(OrderDetailsScreenRoute.name, path: '/orderDetails'),
        _i17.RouteConfig(AddressSelectionScreenRoute.name,
            path: '/addressSelection'),
        _i17.RouteConfig(OrderSuccessScreenRoute.name, path: '/orderSuccess'),
        _i17.RouteConfig(ImageViewerRoute.name, path: '/imageViewer'),
        _i17.RouteConfig(RegistrationScreenRoute.name,
            path: '/registration',
            children: [
              _i17.RouteConfig(CustomerRegistrationScreenRoute.name,
                  path: 'customer', parent: RegistrationScreenRoute.name),
              _i17.RouteConfig(KaPartnerRegistrationScreenRoute.name,
                  path: 'kapartner', parent: RegistrationScreenRoute.name)
            ])
      ];
}

/// generated route for
/// [_i1.LoginFormScreen]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i17.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i17.PageRouteInfo>? children})
      : super(HomeScreenRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.ProductDetails]
class ProductDetailsRoute extends _i17.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({_i18.Key? key, required _i19.ProductModel loadedProduct})
      : super(ProductDetailsRoute.name,
            path: '/productDetails',
            args: ProductDetailsRouteArgs(
                key: key, loadedProduct: loadedProduct));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.loadedProduct});

  final _i18.Key? key;

  final _i19.ProductModel loadedProduct;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, loadedProduct: $loadedProduct}';
  }
}

/// generated route for
/// [_i4.CheckOutScreen]
class CheckOutScreenRoute extends _i17.PageRouteInfo<void> {
  const CheckOutScreenRoute()
      : super(CheckOutScreenRoute.name, path: '/checkout');

  static const String name = 'CheckOutScreenRoute';
}

/// generated route for
/// [_i5.AttachmentViewer]
class AttachmentViewerRoute
    extends _i17.PageRouteInfo<AttachmentViewerRouteArgs> {
  AttachmentViewerRoute(
      {_i18.Key? key,
      required _i20.File imageFile,
      required void Function()? onDelete})
      : super(AttachmentViewerRoute.name,
            path: 'attachmentViewer',
            args: AttachmentViewerRouteArgs(
                key: key, imageFile: imageFile, onDelete: onDelete));

  static const String name = 'AttachmentViewerRoute';
}

class AttachmentViewerRouteArgs {
  const AttachmentViewerRouteArgs(
      {this.key, required this.imageFile, required this.onDelete});

  final _i18.Key? key;

  final _i20.File imageFile;

  final void Function()? onDelete;

  @override
  String toString() {
    return 'AttachmentViewerRouteArgs{key: $key, imageFile: $imageFile, onDelete: $onDelete}';
  }
}

/// generated route for
/// [_i6.OrderDetailsScreen]
class OrderDetailsScreenRoute
    extends _i17.PageRouteInfo<OrderDetailsScreenRouteArgs> {
  OrderDetailsScreenRoute(
      {_i18.Key? key,
      required _i19.OrderItemModel order,
      required String orderTab,
      required _i21.Bloc<dynamic, dynamic> bloc})
      : super(OrderDetailsScreenRoute.name,
            path: '/orderDetails',
            args: OrderDetailsScreenRouteArgs(
                key: key, order: order, orderTab: orderTab, bloc: bloc));

  static const String name = 'OrderDetailsScreenRoute';
}

class OrderDetailsScreenRouteArgs {
  const OrderDetailsScreenRouteArgs(
      {this.key,
      required this.order,
      required this.orderTab,
      required this.bloc});

  final _i18.Key? key;

  final _i19.OrderItemModel order;

  final String orderTab;

  final _i21.Bloc<dynamic, dynamic> bloc;

  @override
  String toString() {
    return 'OrderDetailsScreenRouteArgs{key: $key, order: $order, orderTab: $orderTab, bloc: $bloc}';
  }
}

/// generated route for
/// [_i7.AddressSelectionScreen]
class AddressSelectionScreenRoute
    extends _i17.PageRouteInfo<AddressSelectionScreenRouteArgs> {
  AddressSelectionScreenRoute(
      {_i18.Key? key,
      required _i22.CheckoutFormBloc checkoutBloc,
      required void Function(_i19.CustomerAddressModel?) onSelected,
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

  final _i18.Key? key;

  final _i22.CheckoutFormBloc checkoutBloc;

  final void Function(_i19.CustomerAddressModel?) onSelected;

  final String deliveryMethod;

  @override
  String toString() {
    return 'AddressSelectionScreenRouteArgs{key: $key, checkoutBloc: $checkoutBloc, onSelected: $onSelected, deliveryMethod: $deliveryMethod}';
  }
}

/// generated route for
/// [_i8.OrderSuccessScreen]
class OrderSuccessScreenRoute
    extends _i17.PageRouteInfo<OrderSuccessScreenRouteArgs> {
  OrderSuccessScreenRoute({_i18.Key? key, required String message})
      : super(OrderSuccessScreenRoute.name,
            path: '/orderSuccess',
            args: OrderSuccessScreenRouteArgs(key: key, message: message));

  static const String name = 'OrderSuccessScreenRoute';
}

class OrderSuccessScreenRouteArgs {
  const OrderSuccessScreenRouteArgs({this.key, required this.message});

  final _i18.Key? key;

  final String message;

  @override
  String toString() {
    return 'OrderSuccessScreenRouteArgs{key: $key, message: $message}';
  }
}

/// generated route for
/// [_i9.ImageViewer]
class ImageViewerRoute extends _i17.PageRouteInfo<ImageViewerRouteArgs> {
  ImageViewerRoute(
      {_i18.Key? key,
      required int initialIndex,
      required List<Map<String, dynamic>> attachments})
      : super(ImageViewerRoute.name,
            path: '/imageViewer',
            args: ImageViewerRouteArgs(
                key: key,
                initialIndex: initialIndex,
                attachments: attachments));

  static const String name = 'ImageViewerRoute';
}

class ImageViewerRouteArgs {
  const ImageViewerRouteArgs(
      {this.key, required this.initialIndex, required this.attachments});

  final _i18.Key? key;

  final int initialIndex;

  final List<Map<String, dynamic>> attachments;

  @override
  String toString() {
    return 'ImageViewerRouteArgs{key: $key, initialIndex: $initialIndex, attachments: $attachments}';
  }
}

/// generated route for
/// [_i10.RegistrationScreen]
class RegistrationScreenRoute extends _i17.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i17.PageRouteInfo>? children})
      : super(RegistrationScreenRoute.name,
            path: '/registration', initialChildren: children);

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for
/// [_i11.ProductsScreen]
class ProductsScreenRoute extends _i17.PageRouteInfo<void> {
  const ProductsScreenRoute()
      : super(ProductsScreenRoute.name, path: 'products');

  static const String name = 'ProductsScreenRoute';
}

/// generated route for
/// [_i12.CartScreen]
class CartScreenRoute extends _i17.PageRouteInfo<void> {
  const CartScreenRoute() : super(CartScreenRoute.name, path: 'cart');

  static const String name = 'CartScreenRoute';
}

/// generated route for
/// [_i13.ProfileScreen]
class ProfileScreenRoute extends _i17.PageRouteInfo<void> {
  const ProfileScreenRoute() : super(ProfileScreenRoute.name, path: 'profile');

  static const String name = 'ProfileScreenRoute';
}

/// generated route for
/// [_i14.OrdersScreen]
class OrdersScreenRoute extends _i17.PageRouteInfo<void> {
  const OrdersScreenRoute() : super(OrdersScreenRoute.name, path: 'orders');

  static const String name = 'OrdersScreenRoute';
}

/// generated route for
/// [_i15.CustomerRegistrationScreen]
class CustomerRegistrationScreenRoute extends _i17.PageRouteInfo<void> {
  const CustomerRegistrationScreenRoute()
      : super(CustomerRegistrationScreenRoute.name, path: 'customer');

  static const String name = 'CustomerRegistrationScreenRoute';
}

/// generated route for
/// [_i16.KaPartnerRegistrationScreen]
class KaPartnerRegistrationScreenRoute extends _i17.PageRouteInfo<void> {
  const KaPartnerRegistrationScreenRoute()
      : super(KaPartnerRegistrationScreenRoute.name, path: 'kapartner');

  static const String name = 'KaPartnerRegistrationScreenRoute';
}
