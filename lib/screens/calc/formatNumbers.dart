import 'package:intl/intl.dart';

String formatNumber(double number) {
  var f = NumberFormat('###.0#');

  return f.format(number);
}
