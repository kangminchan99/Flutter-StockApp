import 'package:flutter_test/flutter_test.dart';
import 'package:stock_app/core/utils/constant/config.dart';
import 'package:stock_app/core/utils/injections.dart';
import 'package:stock_app/data/csv/company_listings_parser.dart';
import 'package:stock_app/data/src/remote/stock_api.dart';

void main() {
  setUp(() async {
    await initInjections();
  });
  group('Stock Api Test', () {
    test('네트워크 통신', () async {
      final parser = CompanyListingsParser();

      final response = await StockApi().getListing(Config.stockApiKey);

      final remoteListings = await parser.parse(response.data);

      expect(remoteListings[1].symbol, 'A');
      expect(remoteListings[1].name, 'Agilent Technologies Inc');
      expect(remoteListings[1].exchange, 'NYSE');
    });
  });
}
