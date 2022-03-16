import 'dart:io';

import 'package:intl/intl.dart';

String formatStringToDecimal(String amount, {bool hasCurrency = false}) {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: "PHP");
  String currency = format.currencySymbol;
  var newValue = '';
  final f =
      NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '');
  var num = double.parse(amount.replaceAll(',', ''));
  if (hasCurrency) {
    newValue = currency + f.format(num).trim();
  } else {
    newValue = f.format(num).trim();
  }

  return newValue;
}
