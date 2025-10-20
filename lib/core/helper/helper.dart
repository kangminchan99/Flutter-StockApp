import 'package:intl/intl.dart';

class Helper {
  static Map<String, dynamic> getHeaders() {
    // 헤더가 없으므로 {}로 초기화
    return {}..removeWhere((key, value) => value == null);
  }

  static String formatDate(DateTime value) {
    return DateFormat('HH:mm').format(value);
  }

  static String formatDay(DateTime value) {
    return DateFormat('yy').format(value);
  }
}
