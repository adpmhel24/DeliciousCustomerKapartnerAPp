import 'package:auto_route/auto_route.dart';
import 'package:kapartner_app/presentation/views/default_page/default_screen.dart';
import 'package:kapartner_app/presentation/views/registration_screen/customer_registration/customer_reg_screen.dart';

import '../presentation/views/default_page/screens/cart_screen/cart_screen.dart';
import '../presentation/views/default_page/screens/products_screen/components/prod_details.dart';
import '../presentation/views/default_page/screens/products_screen/products_screen.dart';
import '../presentation/views/default_page/screens/profile_screen/profile_screen.dart';
import '../presentation/views/login_screen/login_screen.dart';
import '../presentation/views/registration_screen/ka_partner_registration/ka_partner_reg.dart';
import '../presentation/views/registration_screen/registration_screen.dart';
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
      ],
    ),
    AutoRoute(
      page: ProductDetails,
      path: '/productDetails',
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
