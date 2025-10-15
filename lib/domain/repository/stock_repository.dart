import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/data/repository/stock_repository_impl.dart';
import 'package:stock_app/data/src/local/stock_dao.dart';
import 'package:stock_app/data/src/remote/stock_api.dart';
import 'package:stock_app/domain/model/company_info_model.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListingModel>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );

  Future<Result<CompanyInfoModel>> getCompanyInfo(String symbol);
}

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  final api = ref.read(stockApiProvider);
  final dao = ref.read(stockDaoProvider);
  return StockRepositoryImpl(api, dao);
});
