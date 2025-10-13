class Helper {
  static Map<String, dynamic> getHeaders() {
    // 헤더가 없으므로 {}로 초기화
    return {}..removeWhere((key, value) => value == null);
  }
}
