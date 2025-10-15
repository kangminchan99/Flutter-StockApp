import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';

class CompanyInfoViewModel extends Notifier<CompanyInfoState> {
  late final StockRepository _repository;

  @override
  CompanyInfoState build() {
    _repository = ref.read(stockRepositoryProvider);
    return const CompanyInfoState();
  }

  Future<void> loadCompanyInfo(String symbol) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getCompanyInfo(symbol);
    result.when(
      success: (company) {
        state = state.copyWith(company: company, isLoading: false);
      },
      failure: (e) {
        state = state.copyWith(company: null, isLoading: false);
      },
    );
  }
}
