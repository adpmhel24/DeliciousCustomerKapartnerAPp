import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'addtocart_event.dart';
part 'addtocart_state.dart';

class AddtocartBloc extends Bloc<AddtocartblocEvent, AddtocartState> {
  AddtocartBloc() : super(const AddtocartState()) {
    on<QuantityChanged>((QuantityChanged event, emit) {
      double discAmount = 0;
      double netTotal = 0;
      double gross = 0;
      AddtocartblocStatus status;

      gross = event.quantity * event.price;
      discAmount = double.parse(
          (gross * double.parse((event.discprcnt / 100).toStringAsFixed(2)))
              .toStringAsFixed(2));
      netTotal = gross - discAmount;

      if (gross <= 0) {
        status = AddtocartblocStatus.invalid;
      } else {
        status = AddtocartblocStatus.valid;
      }

      emit(
        state.copyWith(
          status: status,
          quantity: event.quantity,
          price: event.price,
          discprcnt: event.discprcnt,
          discAmount: discAmount,
          gross: gross,
          netTotal: netTotal,
        ),
      );
    });
  }
}
