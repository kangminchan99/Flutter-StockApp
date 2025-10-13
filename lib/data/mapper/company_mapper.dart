import 'package:stock_app/data/src/local/company_listing_entity.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';

// entity -> model
extension ToCompanyListingModel on CompanyListingEntity {
  CompanyListingModel toCompanyListing() {
    return CompanyListingModel(symbol: symbol, name: name, exchange: exchange);
  }
}

// model -> entity
extension ToCompanyListingEntity on CompanyListingModel {
  CompanyListingEntity toCompanyListingEntity() {
    return CompanyListingEntity(symbol: symbol, name: name, exchange: exchange);
  }
}
