import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(amount);
}
