import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/presentation/utils/text_field_validator.dart';

class CheckoutFormState extends Equatable {
  final FormzStatus status;
  final TextFieldModel deliveryDate;
  final TextFieldModel deliveryMethod;
  final TextFieldModel paymentMethod;
  final TextFieldModel notes;

  const CheckoutFormState({
    this.status = FormzStatus.pure,
    this.deliveryDate = const TextFieldModel.pure(),
    this.deliveryMethod = const TextFieldModel.pure(),
    this.paymentMethod = const TextFieldModel.pure(),
    this.notes = const TextFieldModel.pure(),
  });

  CheckoutFormState copyWith({
    FormzStatus? status,
    TextFieldModel? deliveryDate,
    TextFieldModel? deliveryMethod,
    TextFieldModel? paymentMethod,
    TextFieldModel? notes,
  }) {
    return CheckoutFormState(
      status: status ?? this.status,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        status,
        deliveryDate,
        deliveryMethod,
        paymentMethod,
        notes,
      ];
}
