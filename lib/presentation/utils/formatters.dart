import 'package:intl/intl.dart';

String formatVND2(num amount) {
  return amount.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => ',',
  );
}

double getSoldRatio(int? soldCount, {int max = 2000}) {
  return ((soldCount ?? max).toDouble() / max).clamp(0.0, 1.0);
}

String formatVND(num value) {
  final formatter = NumberFormat('#,###', 'vi_VN');
  return '${formatter.format(value)} VNĐ';
}