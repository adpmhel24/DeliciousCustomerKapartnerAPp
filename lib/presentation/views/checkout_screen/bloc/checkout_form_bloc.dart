import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/data/models/cart_item_model/cart_item_model.dart';
import 'package:kapartner_app/data/models/customer/customer_model.dart';
import 'package:kapartner_app/data/repositories/app_repo.dart';
import 'package:kapartner_app/presentation/utils/text_field_validator.dart';
import 'bloc.dart';

class CheckoutFormBloc extends Bloc<CheckoutFormEvent, CheckoutFormState> {
  CheckoutFormBloc() : super(const CheckoutFormState()) {
    on<CustCodeChanged>(_onCustCodeChanged);
    on<ContactNumberChanged>(_onContactNumberChanged);
    on<AddressChanged>(_onAddressChanged);
    on<DeliveryDateChanged>(_onDeliveryDateChanged);
    on<DeliveryMethodChanged>(_onDeliveryMethodChanged);
    on<PaymentMethodChange>(_onPaymentMethodChange);
    on<NotesChanged>(_onNotesChanged);
    on<AddCartItemsInCheckOutState>(_onAddCartItemsInCheckOutState);
    on<PickupAddressChanged>(_onPickupAddressChanged);
  }

  final CustomerModel _customer = AppRepo.customerInfoRepo.customer;

  void _onCustCodeChanged(
      CustCodeChanged event, Emitter<CheckoutFormState> emit) {
    final custCode = TextFieldModel.dirty(event.custCode);
    emit(
      state.copyWith(
        custCode: custCode,
        status: Formz.validate(
          [
            state.deliveryDate,
            state.deliveryMethod,
            state.paymentMethod,
            state.address
          ],
        ),
      ),
    );
  }

  void _onContactNumberChanged(
      ContactNumberChanged event, Emitter<CheckoutFormState> emit) {
    final contactNumber = TextFieldModel.dirty(event.contactNumber);
    emit(
      state.copyWith(
        contactNumber: contactNumber,
        status: Formz.validate(
          [
            state.deliveryDate,
            state.deliveryMethod,
            state.paymentMethod,
            state.address
          ],
        ),
      ),
    );
  }

  void _onAddCartItemsInCheckOutState(
      AddCartItemsInCheckOutState event, Emitter<CheckoutFormState> emit) {
    final List<CartItemModel> items = List<CartItemModel>.from(json
        .decode(json.encode(event.items))
        .map((e) => CartItemModel.fromJson(e))
        .toList());
    emit(
      state.copyWith(
        items: items,
        status: Formz.validate(
          [
            state.deliveryDate,
            state.deliveryMethod,
            state.paymentMethod,
            state.address
          ],
        ),
      ),
    );
  }

  void _onAddressChanged(
      AddressChanged event, Emitter<CheckoutFormState> emit) {
    final stringAddress = "${event.selectedAddress?.streetAddress ?? ''} "
        "${event.selectedAddress?.brgy ?? ''} "
        "${event.selectedAddress?.cityMunicipality ?? ''}";
    final address = TextFieldModel.dirty(stringAddress);
    final delfee = TextFieldModel.dirty(
        event.selectedAddress?.deliveryFee.toString() ?? '0.0');
    emit(
      state.copyWith(
        address: address,
        delfee: delfee,
        status: Formz.validate(
          [
            state.deliveryDate,
            state.deliveryMethod,
            state.paymentMethod,
            address
          ],
        ),
      ),
    );
  }

  void _onPickupAddressChanged(
      PickupAddressChanged event, Emitter<CheckoutFormState> emit) {
    final address = TextFieldModel.dirty(event.pickupAddress);
    const delfee = TextFieldModel.dirty('0.00');
    emit(
      state.copyWith(
        address: address,
        delfee: delfee,
        status: Formz.validate(
          [
            state.deliveryDate,
            state.deliveryMethod,
            state.paymentMethod,
            address
          ],
        ),
      ),
    );
  }

  void _onDeliveryDateChanged(
      DeliveryDateChanged event, Emitter<CheckoutFormState> emit) {
    final deliveryDate = TextFieldModel.dirty(event.deliveryDate);
    emit(
      state.copyWith(
        deliveryDate: deliveryDate,
        status: Formz.validate(
          [
            deliveryDate,
            state.deliveryMethod,
            state.paymentMethod,
            state.address
          ],
        ),
      ),
    );
  }

  void _onDeliveryMethodChanged(
      DeliveryMethodChanged event, Emitter<CheckoutFormState> emit) {
    final deliveryMethod = TextFieldModel.dirty(event.deliveryMethod);
    const address = TextFieldModel.dirty();
    final List<CartItemModel> items = state.items.toList();
    double discount = 0;
    // double deliveryFee = 0;

    if (event.deliveryMethod.toLowerCase() == 'pickup') {
      discount = (_customer.allowedDisc ?? 0) + (_customer.pickupDisc ?? 0);
      // deliveryFee = 0;
    } else {
      discount = (_customer.allowedDisc ?? 0);
      // deliveryFee = event.deliveryFee;
    }

    for (final cartItem in items) {
      double gross = cartItem.quantity * (cartItem.price ?? 0);
      cartItem.discprcnt = discount;
      var disc = double.parse((cartItem.discprcnt / 100).toStringAsFixed(2));
      double discAmount = double.parse((gross * disc).toStringAsFixed(2));
      cartItem.discAmount = discAmount;
      cartItem.total = double.parse((gross - discAmount).toStringAsFixed(2));
    }

    emit(
      state.copyWith(
        deliveryMethod: deliveryMethod,
        address: address,
        delfee: const TextFieldModel.dirty('0.00'),
        items: items,
        status: Formz.validate(
          [
            deliveryMethod,
            state.deliveryDate,
            state.paymentMethod,
            address,
          ],
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
          [
            paymentMethod,
            state.deliveryDate,
            state.deliveryMethod,
            state.address
          ],
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
          [
            state.paymentMethod,
            state.deliveryDate,
            state.deliveryMethod,
            state.address
          ],
        ),
      ),
    );
  }
}
