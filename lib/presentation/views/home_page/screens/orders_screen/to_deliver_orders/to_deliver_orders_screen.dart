import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';

import '../components.dart/order_card.dart';
import 'bloc/bloc.dart';

class ToDeliverOrdersScreen extends StatelessWidget {
  const ToDeliverOrdersScreen({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<ToDeliverOrderBloc>(context).add(FetchToDeliverOrders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDeliverOrderBloc>(
      create: (context) => ToDeliverOrderBloc()..add(FetchToDeliverOrders()),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocConsumer<ToDeliverOrderBloc, ToDeliverOrderState>(
              listener: (_, state) {
                if (state.status == ToDeliverOrderStateStatus.loading) {
                  CustomDialog.loading(context);
                } else if (state.status == ToDeliverOrderStateStatus.error) {
                  CustomDialog.error(context, message: state.message);
                } else if (state.status == ToDeliverOrderStateStatus.success) {
                  Navigator.of(context).pop();
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
                        return OrderCard(order: state.orders[indx]!);
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
