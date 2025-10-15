import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_app/domain/model/company_info_model.dart';

part 'company_info_state.freezed.dart';

@freezed
abstract class CompanyInfoState with _$CompanyInfoState {
  const factory CompanyInfoState({
    @Default(false) bool isLoading,
    CompanyInfoModel? company,
    String? errorMsg,
    String? information,
  }) = _CompanyInfoState;
}
