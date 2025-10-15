import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_model.freezed.dart';
part 'company_info_model.g.dart';

@freezed
abstract class CompanyInfoModel with _$CompanyInfoModel {
  const factory CompanyInfoModel({
    required String symbol,
    required String description,
    required String name,
    required String country,
    required String industry,
    @Default('') String information,
  }) = _CompanyInfoModel;

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoModelFromJson(json);
}
