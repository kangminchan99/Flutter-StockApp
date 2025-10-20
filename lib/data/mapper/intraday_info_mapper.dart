import 'package:intl/intl.dart';
import 'package:stock_app/data/src/remote/dto/intraday_info_dto.dart';
import 'package:stock_app/domain/model/intraday_info_model.dart';

// dto -> model
extension ToIntradayInfoModel on IntradayInfoDto {
  IntradayInfoModel toIntradayInfoModel() {
    // 2022-06-27 19:15:00
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return IntradayInfoModel(date: formatter.parse(timestamp), close: close);
  }
}
