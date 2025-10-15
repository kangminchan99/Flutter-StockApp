import 'package:stock_app/core/utils/constant/config.dart';

String getListingsPath() {
  return '${Config.stockBaseUrl}query?function=LISTING_STATUS&apikey=${Config.stockApiKey}';
}

String getCompanyInfoPath(String symbol) {
  return '${Config.stockBaseUrl}query?function=OVERVIEW&symbol=$symbol&apikey=${Config.stockApiKey}';
}
