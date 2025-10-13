import 'package:stock_app/core/utils/constant/config.dart';

String getListingsPath() {
  return '${Config.stockBaseUrl}query?function=LISTING_STATUS&apikey=${Config.stockApiKey}';
}
