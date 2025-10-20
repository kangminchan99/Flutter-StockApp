import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/domain/model/company_info_model.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';
import 'package:stock_app/domain/model/intraday_info_model.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';

class FakeStockRepository implements StockRepository {
  @override
  Future<Result<List<CompanyListingModel>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  ) async {
    return Result.success([
      CompanyListingModel(symbol: 'A', name: 'Agilent', exchange: 'NYSE'),
    ]);
  }

  @override
  Future<Result<CompanyInfoModel>> getCompanyInfo(String symbol) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<IntradayInfoModel>>> getIntradayInfo(String symbol) {
    throw UnimplementedError();
  }
}
