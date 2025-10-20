import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';

class CompanyInfoViewModel extends FamilyNotifier<CompanyInfoState, String> {
  late final StockRepository _repository;

  @override
  CompanyInfoState build(String symbol) {
    _repository = ref.read(stockRepositoryProvider);

    final initial = const CompanyInfoState();

    Future.microtask(() => loadCompanyInfo(symbol));

    return initial;
  }

  Future<void> loadCompanyInfo(String symbol) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getCompanyInfo(symbol);
    result.when(
      success: (company) {
        state = state.copyWith(
          company: company,
          isLoading: false,
          errorMsg: null,
          information: company.information,
        );
      },
      failure: (e) {
        state = state.copyWith(
          company: null,
          isLoading: false,
          errorMsg: e.toString(),
        );
      },
    );

    final intradayInfo = await _repository.getIntradayInfo(symbol);

    intradayInfo.when(
      success: (info) {
        state = state.copyWith(
          stockInfos: info,
          isLoading: false,
          errorMsg: null,
        );
      },
      failure: (e) {
        final errorInfoMsg = 'Failed to load intraday info: ${e.toString()}';
        state = state.copyWith(
          isLoading: false,
          errorMsg: errorInfoMsg,
          stockInfos: [],
        );
      },
    );
  }
}

final companyInfoVmProvider =
    NotifierProvider.family<CompanyInfoViewModel, CompanyInfoState, String>(
      () => CompanyInfoViewModel(),
    );
