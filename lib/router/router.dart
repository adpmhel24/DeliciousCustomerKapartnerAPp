import 'package:auto_route/auto_route.dart';
import 'package:kapartner_app/presentation/views/home_page/home_screen.dart';
import 'package:kapartner_app/presentation/views/registration_screen/customer_registration/customer_reg_screen.dart';

import '../presentation/views/checkout_screen/checkout_screen.dart';
import '../presentation/views/checkout_screen/components/address_selection.dart';
import '../presentation/views/checkout_screen/components/attachment_viewer.dart';
import '../presentation/views/home_page/screens/cart_screen/cart_screen.dart';
import '../presentation/views/home_page/screens/orders_screen/order_details_screen/order_details_screen.dart';
import '../presentation/views/home_page/screens/orders_screen/orders_screen.dart';
import '../presentation/views/home_page/screens/products_screen/components/prod_details.dart';
import '../presentation/views/home_page/screens/products_screen/products_screen.dart';
import '../presentation/views/home_page/screens/profile_screen/profile_screen.dart';
import '../presentation/views/login_screen/login_screen.dart';
import '../presentation/views/order_success_screen/order_success_screen.dart';
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart';
import '../presentation/views/registration_screen/registration_screen.dart';
import '../presentation/widget/image_viewer.dart';
import 'router_guard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginFormScreen, name: 'LoginRoute', path: '/login'),
    AutoRoute(
      path: '/',
      page: HomeScreen,
      guards: [RouteGuard],
      children: [
        AutoRoute(path: 'products', page: ProductsScreen, initial: true),
        AutoRoute(
          path: 'cart',
          page: CartScreen,
        ),
        AutoRoute(path: 'profile', page: ProfileScreen),
        AutoRoute(path: 'orders', page: OrdersScreen),
      ],
    ),
    AutoRoute(
      page: ProductDetails,
      path: '/productDetails',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: CheckOutScreen,
      path: '/checkout',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: AttachmentViewer,
      path: 'attachmentViewer',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: OrderDetailsScreen,
      path: '/orderDetails',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: AddressSelectionScreen,
      path: '/addressSelection',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: OrderSuccessScreen,
      path: '/orderSuccess',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: ImageViewer,
      path: '/imageViewer',
      guards: [RouteGuard],
    ),
    AutoRoute(
      page: RegistrationScreen,
      path: '/registration',
      children: [
        AutoRoute(path: 'customer', page: CustomerRegistrationScreen),
        AutoRoute(path: 'kapartner', page: KaPartnerRegistrationScreen),
      ],
    ),
    // AutoRoute(
    //   page: CreateOrderScreen,
    //   path: '/',
    //   guards: [RouteGuard],
    //   children: <AutoRoute>[
    //     AutoRoute(page: CustomerSelectionScreen, path: '', initial: true),
    //     AutoRoute(page: ProductSelectionScreen, path: 'product'),
    //   ],
    // ),
    // AutoRoute(page: AddNewCustomerScreen, path: '/new_customer'),
    // AutoRoute(page: CartScreen, path: '/cart'),
    // AutoRoute(
    //   page: OrderScreen,
    //   path: '/orders',
    //   guards: [RouteGuard],
    //   children: <AutoRoute>[
    //     AutoRoute(page: PendingOrdersScreen, path: 'pending_orders'),
    //     AutoRoute(page: ForPickupDeliverScreen, path: 'for_pickup_deliver'),
    //     AutoRoute(page: CompletedOrderScreen, path: 'completed_order'),
    //   ],
    // ),
    // AutoRoute(
    //     page: CustomerTypeScreen,
    //     guards: [RouteGuard],
    //     path: '/customer_types'),
    // AutoRoute(
    //     page: CreateCustomerType,
    //     guards: [RouteGuard],
    //     path: '/create_customer_types'),
  ],
)
class $AppRouter {}
