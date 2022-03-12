import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/presentation/utils/text_field_validator.dart';

class CheckoutFormState extends Equatable {
  final FormzStatus status;
  final TextFieldModel custCode;
  final TextFieldModel contactNumber;
  final TextFieldModel address;
  final TextFieldModel delfee;
  final TextFieldModel deliveryDate;
  final TextFieldModel deliveryMethod;
  final TextFieldModel paymentMethod;
  final TextFieldModel notes;

  const CheckoutFormState({
    this.status = FormzStatus.pure,
    this.custCode = const TextFieldModel.pure(),
    this.contactNumber = const TextFieldModel.pure(),
    this.address = const TextFieldModel.pure(),
    this.delfee = const TextFieldModel.dirty("0.00"),
    this.deliveryDate = const TextFieldModel.pure(),
    this.deliveryMethod = const TextFieldModel.pure(),
    this.paymentMethod = const TextFieldModel.pure(),
    this.notes = const TextFieldModel.pure(),
  });

  CheckoutFormState copyWith({
    FormzStatus? status,
    TextFieldModel? custCode,
    TextFieldModel? contactNumber,
    TextFieldModel? address,
    TextFieldModel? delfee,
    TextFieldModel? deliveryDate,
    TextFieldModel? deliveryMethod,
    TextFieldModel? paymentMethod,
    TextFieldModel? notes,
  }) {
    return CheckoutFormState(
      status: status ?? this.status,
      custCode: custCode ?? this.custCode,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      delfee: delfee ?? this.delfee,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        status,
        custCode,
        contactNumber,
        address,
        delfee,
        deliveryDate,
        deliveryMethod,
        paymentMethod,
        notes,
      ];
}
