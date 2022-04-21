part of 'bloc.dart';

class AddAttachmentToOrderState extends Equatable {
  const AddAttachmentToOrderState({
    this.status = FormzStatus.pure,
    this.order,
    this.message = '',
    this.attachments = const [],
  });

  final FormzStatus status;
  final OrderItemModel? order;
  final List<File> attachments;
  final String message;

  AddAttachmentToOrderState copyWith({
    FormzStatus? status,
    OrderItemModel? order,
    List<File>? attachments,
    String? message,
  }) {
    return AddAttachmentToOrderState(
        status: status ?? this.status,
        order: order ?? this.order,
        attachments: attachments ?? this.attachments,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        status,
        order,
        attachments,
        message,
      ];
}
