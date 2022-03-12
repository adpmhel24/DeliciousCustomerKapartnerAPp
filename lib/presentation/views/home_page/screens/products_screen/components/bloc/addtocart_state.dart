part of 'addtocart_bloc.dart';

enum AddtocartblocStatus { init, valid, invalid }

class AddtocartState extends Equatable {
  const AddtocartState({
    this.status = AddtocartblocStatus.init,
    this.quantity = 0.00,
    this.price = 0.00,
    this.discAmount = 0.00,
    this.discprcnt = 0.00,
    this.gross = 0.00,
    this.netTotal = 0.00,
  });

  final AddtocartblocStatus status;
  final double quantity;
  final double price;
  final double discprcnt;
  final double discAmount;
  final double gross;
  final double netTotal;

  AddtocartState copyWith({
    AddtocartblocStatus? status,
    double? quantity,
    double? price,
    double? discprcnt,
    double? discAmount,
    double? netTotal,
    double? gross,
  }) {
    return AddtocartState(
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discprcnt: discprcnt ?? this.discprcnt,
      discAmount: discAmount ?? this.discAmount,
      netTotal: netTotal ?? this.netTotal,
      gross: gross ?? this.gross,
    );
  }

  @override
  List<Object> get props =>
      [status, quantity, price, discAmount, gross, netTotal];
}
