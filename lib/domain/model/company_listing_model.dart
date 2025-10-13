import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listing_model.freezed.dart';
part 'company_listing_model.g.dart';

@freezed
abstract class CompanyListingModel with _$CompanyListingModel {
  const factory CompanyListingModel({
    required String symbol,
    required String name,
    required String exchange,
  }) = _CompanyListingModel;

  factory CompanyListingModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyListingModelFromJson(json);
}
