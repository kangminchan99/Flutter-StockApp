import 'package:csv/csv.dart';
import 'package:stock_app/data/csv/csv_parser.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';

class FakeCompanyListingsParser implements CsvParser<CompanyListingModel> {
  @override
  Future<List<CompanyListingModel>> parse(String csvString) async {
    // 1) 줄바꿈 정규화
    final normalized = csvString
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .trim();

    // 2) CSV 파싱 (숫자 파싱 끔: shouldParseNumbers: false)
    final csvValues = const CsvToListConverter(
      shouldParseNumbers: false,
    ).convert(normalized);

    if (csvValues.isEmpty) return [];

    // 4) 매핑
    return csvValues
        .where((e) => e.length >= 3) // 컬럼 수 방어
        .map(
          (e) => CompanyListingModel(
            symbol: (e[0] ?? '').toString().trim(),
            name: (e[1] ?? '').toString().trim(),
            exchange: (e[2] ?? '').toString().trim(),
          ),
        )
        .where(
          (e) =>
              e.symbol.isNotEmpty && e.name.isNotEmpty && e.exchange.isNotEmpty,
        )
        .toList();
  }
}
