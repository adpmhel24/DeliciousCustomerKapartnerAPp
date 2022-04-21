import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../components.dart/order_card.dart';
import 'bloc/bloc.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  const DeliveredOrdersScreen({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<DeliveredOrdersBloc>(context).add(FetchDeliveredOrders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeliveredOrdersBloc>(
      create: (context) => DeliveredOrdersBloc()..add(FetchDeliveredOrders()),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocConsumer<DeliveredOrdersBloc, DeliveredOrdersState>(
              listener: (_, state) {
                if (state.status == DeliveredOrdersStateStatus.loading) {
                  context.loaderOverlay.show();
                } else if (state.status == DeliveredOrdersStateStatus.error) {
                  CustomDialog.error(context, message: state.message);
                } else if (state.status == DeliveredOrdersStateStatus.success) {
                  context.loaderOverlay.hide();
                }
              },
              builder: (_, state) {
                return RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 10.w,
                    ),
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (_, indx) {
                        return OrderCard(
                          order: state.orders[indx]!,
                          orderTab: 'Completed',
                          bloc: BlocProvider.of<DeliveredOrdersBloc>(context),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
