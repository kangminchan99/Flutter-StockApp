import 'package:csv/csv.dart';
import 'package:stock_app/data/csv/csv_parser.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';

class CompanyListingsParser implements CsvParser<CompanyListingModel> {
  @override
  Future<List<CompanyListingModel>> parse(String csvString) async {
    List<List<dynamic>> csvValues = CsvToListConverter().convert(csvString);

    csvValues.removeAt(0);

    return csvValues
        .map((e) {
          final symbol = e[0] ?? '';
          final name = e[1] ?? '';
          final exchange = e[2] ?? '';
          return CompanyListingModel(
            symbol: symbol,
            name: name,
            exchange: exchange,
          );
        })
        .where(
          (e) =>
              e.symbol.isNotEmpty && e.name.isNotEmpty && e.exchange.isNotEmpty,
        )
        .toList();
  }
}
