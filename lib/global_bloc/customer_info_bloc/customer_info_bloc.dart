import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'bloc.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  final CustomerInfoRepo _customerInfoRepo = AppRepo.customerInfoRepo;

  CustomerInfoBloc() : super(const CustomerInfoState()) {
    on<GetCustomerInfo>(_onGetCustomerInfo);
    on<ContactNumberUpdated>(_onContactNumberUpdated);
    on<EmailAddressUpdated>(_onEmailAddressUpdated);
    on<UpdateCustomerDetail>(_onUpdateCustomerDetail);
    on<UpdateToDefaultAddress>(_onUpdateToDefaultAddress);
    on<AddNewCustomerDetail>(_onAddNewCustomerDetail);
    on<DeleteCustomerAddressDetail>(_onDeleteCustomerAddressDetail);
  }

  void _onGetCustomerInfo(
      GetCustomerInfo event, Emitter<CustomerInfoState> emit) {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));
    try {
      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }

  void _onContactNumberUpdated(
      ContactNumberUpdated event, Emitter<CustomerInfoState> emit) async {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));

    try {
      await _customerInfoRepo
          .updateCustomer(data: {"contact_number": event.contactNumber});

      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }

  void _onEmailAddressUpdated(
      EmailAddressUpdated event, Emitter<CustomerInfoState> emit) async {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));

    try {
      await _customerInfoRepo.updateCustomer(data: {"email": event.email});

      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }

  void _onUpdateCustomerDetail(
      UpdateCustomerDetail event, Emitter<CustomerInfoState> emit) async {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));

    try {
      await _customerInfoRepo.updateCustomerDetail(
          customerDetailId: event.addressModel.id!,
          data: event.addressModel.toJson());

      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }

  void _onUpdateToDefaultAddress(
      UpdateToDefaultAddress event, Emitter<CustomerInfoState> emit) async {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));

    try {
      await _customerInfoRepo.updateCustomerDetail(
          customerDetailId: event.customerDetailId,
          data: {'is_default': event.isDefault});

      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }

  void _onAddNewCustomerDetail(
      AddNewCustomerDetail event, Emitter<CustomerInfoState> emit) async {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));

    try {
      await _customerInfoRepo.addNewCustomerDetails(
        customerId: event.customerId,
        data: event.addressModel.toJson(),
      );

      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }

  void _onDeleteCustomerAddressDetail(DeleteCustomerAddressDetail event,
      Emitter<CustomerInfoState> emit) async {
    emit(state.copyWith(status: CustomerInfoStateStatus.loading));

    try {
      await _customerInfoRepo.deleteCustomerAddressDetail(
        customerDetailsID: event.customerDetailId,
      );

      emit(state.copyWith(
        customerInfo: _customerInfoRepo.customer,
        status: CustomerInfoStateStatus.fetched,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          message: e.message, status: CustomerInfoStateStatus.error));
    }
  }
}
