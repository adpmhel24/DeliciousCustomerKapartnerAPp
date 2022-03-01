import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/presentation/utils/text_field_validator.dart';
import 'bloc.dart';

class CheckoutFormBloc extends Bloc<CheckoutFormEvent, CheckoutFormState> {
  CheckoutFormBloc() : super(const CheckoutFormState()) {
    on<DeliveryDateChanged>(_onDeliveryDateChanged);
    on<DeliveryMethodChanged>(_onDeliveryMethodChanged);
    on<PaymentMethodChange>(_onPaymentMethodChange);
    on<NotesChanged>(_onNotesChanged);
  }

  void _onDeliveryDateChanged(
      DeliveryDateChanged event, Emitter<CheckoutFormState> emit) {
    final deliveryDate = TextFieldModel.dirty(event.deliveryDate);
    emit(
      state.copyWith(
        deliveryDate: deliveryDate,
        status: Formz.validate(
          [deliveryDate, state.deliveryMethod, state.paymentMethod],
        ),
      ),
    );
  }

  void _onDeliveryMethodChanged(
      DeliveryMethodChanged event, Emitter<CheckoutFormState> emit) {
    final deliveryMethod = TextFieldModel.dirty(event.deliveryMethod);
    emit(
      state.copyWith(
        deliveryMethod: deliveryMethod,
        status: Formz.validate(
          [deliveryMethod, state.deliveryDate, state.paymentMethod],
        ),
      ),
    );
  }

  void _onPaymentMethodChange(
      PaymentMethodChange event, Emitter<CheckoutFormState> emit) {
    final paymentMethod = TextFieldModel.dirty(event.paymentMethod);
    emit(
      state.copyWith(
        paymentMethod: paymentMethod,
        status: Formz.validate(
          [paymentMethod, state.deliveryDate, state.deliveryMethod],
        ),
      ),
    );
  }

  void _onNotesChanged(NotesChanged event, Emitter<CheckoutFormState> emit) {
    final notes = TextFieldModel.dirty(event.notes);
    emit(
      state.copyWith(
        notes: notes,
        status: Formz.validate(
          [state.paymentMethod, state.deliveryDate, state.deliveryMethod],
        ),
      ),
    );
  }
}
