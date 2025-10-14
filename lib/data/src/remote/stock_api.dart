import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/logger_interceptor.dart';
import 'package:stock_app/core/utils/constant/network_constant.dart';

class StockApi {
  final Dio _dio;

  StockApi({required Dio dio}) : _dio = dio;

  Future<Response> getListing(String apiKey) async {
    return await _dio.get(getListingsPath());
  }
}

final stockApiProvider = Provider<StockApi>((ref) {
  final dio = ref.read(dioProvider);
  return StockApi(dio: dio);
});
