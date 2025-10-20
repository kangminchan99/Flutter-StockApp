import 'package:freezed_annotation/freezed_annotation.dart';

part 'intraday_info_dto.freezed.dart';

part 'intraday_info_dto.g.dart';

@freezed
abstract class IntradayInfoDto with _$IntradayInfoDto {
  const factory IntradayInfoDto({
    required double close,
    required String timestamp,
  }) = _IntradayInfoDto;

  factory IntradayInfoDto.fromJson(Map<String, dynamic> json) =>
      _$IntradayInfoDtoFromJson(json);
}
