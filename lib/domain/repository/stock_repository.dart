import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListingModel>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );
}
