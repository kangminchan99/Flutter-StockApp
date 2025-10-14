import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel extends Notifier<CompanyListingsState> {
  // repository가 많을 경우 usecase로 묶어서 하는게 좋음
  late final StockRepository _repository;

  @override
  CompanyListingsState build() {
    _repository = ref.read(stockRepositoryProvider);
    // 1) 초기 상태
    final initial = const CompanyListingsState();

    // 2) 초기 로딩은 다음 마이크로태스크로
    Future.microtask(() => getCompanyListings());

    return initial;
  }

  Future<void> getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        state = state.copyWith(companies: listings);
      },
      failure: (e) {
        // TODO: error 처리
        print('리모트 에러 $e');
      },
    );
    state = state.copyWith(isLoading: false);
  }
}

final companyListingsVmProvider =
    NotifierProvider<CompanyListingsViewModel, CompanyListingsState>(
      () => CompanyListingsViewModel(),
    );
