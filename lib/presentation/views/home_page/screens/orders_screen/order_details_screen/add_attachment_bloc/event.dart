part of 'bloc.dart';

abstract class AddAttachmentToOrderEvent extends Equatable {
  const AddAttachmentToOrderEvent();

  @override
  List<Object> get props => [];
}

class AttachmentAdded extends AddAttachmentToOrderEvent {
  final File attachment;
  const AttachmentAdded(this.attachment);
  @override
  List<Object> get props => [attachment];
}

class AttachmentRemoved extends AddAttachmentToOrderEvent {
  final int index;

  const AttachmentRemoved(this.index);
  @override
  List<Object> get props => [index];
}

class AttachmentSubmitted extends AddAttachmentToOrderEvent {
  final int orderId;

  const AttachmentSubmitted(this.orderId);
  @override
  List<Object> get props => [orderId];
}
