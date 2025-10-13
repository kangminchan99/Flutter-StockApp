import 'package:dio/dio.dart';
import 'package:stock_app/core/network/dio_network.dart';
import 'package:stock_app/core/utils/constant/network_constant.dart';

class StockApi {
  final Dio _dio;

  StockApi({Dio? dio}) : _dio = dio ?? DioNetwork.appAPI;

  Future<Response> getListing(String apiKey) async {
    return await _dio.get(getListingsPath());
  }
}
