import 'package:csv/csv.dart';
import 'package:stock_app/data/csv/csv_parser.dart';
import 'package:stock_app/data/mapper/intraday_info_mapper.dart';
import 'package:stock_app/data/src/remote/dto/intraday_info_dto.dart';
import 'package:stock_app/domain/model/intraday_info_model.dart';

class IntradayInfoParser implements CsvParser<IntradayInfoModel> {
  @override
  Future<List<IntradayInfoModel>> parse(String csvString) async {
    List<List<dynamic>> csvValues = CsvToListConverter().convert(csvString);

    csvValues.removeAt(0);

    return csvValues.map((e) {
      final timeStamp = e[0] ?? '';
      final close = e[4] ?? 0.0;

      final dto = IntradayInfoDto(timestamp: timeStamp, close: close);

      return dto.toIntradayInfoModel();
    }).toList();
  }
}
