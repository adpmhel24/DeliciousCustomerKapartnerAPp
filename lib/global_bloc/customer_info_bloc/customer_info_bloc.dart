import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repositories.dart';
import 'bloc.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  final CustomerInfoRepo _customerInfoRepo = AppRepo.customerInfoRepo;

  CustomerInfoBloc() : super(CustomerInfoInitState()) {
    on<GetCustomerInfo>(_onGetCustomerInfo);
    on<ContactNumberUpdated>(_onContactNumberUpdated);
    on<EmailAddressUpdated>(_onEmailAddressUpdated);
    on<UpdateCustomerDetail>(_onUpdateCustomerDetail);
  }

  void _onGetCustomerInfo(
      GetCustomerInfo event, Emitter<CustomerInfoState> emit) {
    emit(CustomerInfoLoading());
    try {
      emit(CustomerInfoLoaded(_customerInfoRepo.customer));
    } on HttpException catch (e) {
      emit(CustomerInfoError(e.message));
    }
  }

  void _onContactNumberUpdated(
      ContactNumberUpdated event, Emitter<CustomerInfoState> emit) async {
    emit(CustomerInfoLoading());
    try {
      await _customerInfoRepo
          .updateCustomer(data: {"contact_number": event.contactNumber});

      emit(CustomerInfoLoaded(_customerInfoRepo.customer));
    } on HttpException catch (e) {
      emit(CustomerInfoError(e.message));
    }
  }

  void _onEmailAddressUpdated(
      EmailAddressUpdated event, Emitter<CustomerInfoState> emit) async {
    emit(CustomerInfoLoading());
    try {
      await _customerInfoRepo.updateCustomer(data: {"email": event.email});

      emit(CustomerInfoLoaded(_customerInfoRepo.customer));
    } on HttpException catch (e) {
      emit(CustomerInfoError(e.message));
    }
  }

  void _onUpdateCustomerDetail(
      UpdateCustomerDetail event, Emitter<CustomerInfoState> emit) async {
    emit(CustomerInfoLoading());
    try {
      await _customerInfoRepo.updateCustomerDetail(
          customerDetailId: event.orderDetailId,
          data: event.addressModel.toJson());

      emit(CustomerInfoLoaded(_customerInfoRepo.customer));
    } on HttpException catch (e) {
      emit(CustomerInfoError(e.message));
    }
  }
}
