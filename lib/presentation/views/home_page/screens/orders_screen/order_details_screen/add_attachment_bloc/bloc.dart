import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/data/models/order/order_model.dart';

import 'package:kapartner_app/data/repositories/repositories.dart';

part 'event.dart';
part 'state.dart';

class AddAttachmentToOrderBloc
    extends Bloc<AddAttachmentToOrderEvent, AddAttachmentToOrderState> {
  final OrderRepo _orderRepo = AppRepo.orderRepository;
  AddAttachmentToOrderBloc() : super(const AddAttachmentToOrderState()) {
    on<AttachmentAdded>(_onAttachmentAdded);
    on<AttachmentRemoved>(_onAttachmentRemoved);
    on<AttachmentSubmitted>(_onAttachmentSubmitted);
  }

  void _onAttachmentAdded(
      AttachmentAdded event, Emitter<AddAttachmentToOrderState> emit) {
    List<File> stateAttachment =
        state.attachments.isEmpty ? [] : state.attachments;
    emit(
      state.copyWith(
        attachments: [...stateAttachment, event.attachment],
        status: FormzStatus.valid,
      ),
    );
  }

  void _onAttachmentRemoved(
      AttachmentRemoved event, Emitter<AddAttachmentToOrderState> emit) {
    List<File> attachments = state.attachments.map((e) => e).toList();

    attachments.removeAt(event.index);

    var status = state.status;

    if (attachments.isEmpty) {
      status = FormzStatus.pure;
    }

    emit(
      state.copyWith(
        attachments: [...attachments],
        status: status,
      ),
    );
  }

  void _onAttachmentSubmitted(AttachmentSubmitted event,
      Emitter<AddAttachmentToOrderState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      OrderItemModel order = await _orderRepo.addOrderAttachment(
          orderId: event.orderId, files: state.attachments);
      emit(state.copyWith(status: FormzStatus.submissionSuccess, order: order));
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          message: e.message,
        ),
      );
      emit(
        state.copyWith(
          status: FormzStatus.valid,
        ),
      );
    }
  }
}
