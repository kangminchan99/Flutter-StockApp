import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/logger_interceptor.dart';
import 'package:stock_app/core/utils/constant/network_constant.dart';
import 'package:stock_app/data/src/remote/dto/company_info_dto.dart';

class StockApi {
  final Dio _dio;

  StockApi({required Dio dio}) : _dio = dio;

  Future<Response> getListing(String apiKey) async {
    return await _dio.get(getListingsPath());
  }

  Future<CompanyInfoDto> getCompanyInfo(
    String apiKey, {
    required String symbol,
  }) async {
    final response = await _dio.get(getCompanyInfoPath(symbol));

    return CompanyInfoDto.fromJson(response.data);
  }

  Future<Response> getIntradayInfo(
    String apiKey, {
    required String symbol,
  }) async {
    return await _dio.get(getIntradayInfoPath(symbol));
  }
}

final stockApiProvider = Provider<StockApi>((ref) {
  final dio = ref.read(dioProvider);
  return StockApi(dio: dio);
});
