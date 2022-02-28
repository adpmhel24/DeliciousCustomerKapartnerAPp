import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderBlocInitState());

  // Future<void> _onPlaceNewOrder(PlaceNewOrder event, Emitter<OrderState> emit){
  //   Map<String, dynamic> data = {

  //   }
  // }
}
