import 'package:dio/dio.dart';
import 'package:stock_app/core/utils/constant/network_constant.dart';

class StockApi {
  final Dio dio;

  StockApi(this.dio);

  Future<Response> getListing(String apiKey) async {
    return await dio.get(getListingsPath());
  }
}
