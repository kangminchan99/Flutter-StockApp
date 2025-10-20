import 'package:freezed_annotation/freezed_annotation.dart';

part 'intraday_info_model.freezed.dart';
part 'intraday_info_model.g.dart';

@freezed
abstract class IntradayInfoModel with _$IntradayInfoModel {
  const factory IntradayInfoModel({
    required double close,
    required DateTime date,
  }) = _IntradayInfoModel;

  factory IntradayInfoModel.fromJson(Map<String, dynamic> json) =>
      _$IntradayInfoModelFromJson(json);
}
