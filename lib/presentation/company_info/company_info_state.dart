import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_app/domain/model/company_info_model.dart';
import 'package:stock_app/domain/model/intraday_info_model.dart';

part 'company_info_state.freezed.dart';
part 'company_info_state.g.dart';

@freezed
abstract class CompanyInfoState with _$CompanyInfoState {
  const factory CompanyInfoState({
    @Default(false) bool isLoading,
    CompanyInfoModel? company,
    String? errorMsg,
    String? information,
    @Default([]) List<IntradayInfoModel> stockInfos,
  }) = _CompanyInfoState;

  factory CompanyInfoState.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoStateFromJson(json);
}
