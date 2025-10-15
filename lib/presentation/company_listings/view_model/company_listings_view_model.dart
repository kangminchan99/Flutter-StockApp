import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_listings/company_listings_action.dart';
import 'package:stock_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel extends Notifier<CompanyListingsState> {
  // repository가 많을 경우 usecase로 묶어서 하는게 좋음
  late final StockRepository _repository;

  Timer? _debounce;

  @override
  CompanyListingsState build() {
    _repository = ref.read(stockRepositoryProvider);
    // 1) 초기 상태
    final initial = const CompanyListingsState();

    // 2) 초기 로딩은 다음 마이크로태스크로
    Future.microtask(() => getCompanyListings());

    return initial;
  }

  void onAction(CompanyListingsAction action) {
    action.when(
      refresh: () => getCompanyListings(fetchFromRemote: true),
      onSearchQueryChange: (query) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          getCompanyListings(query: query);
        });
      },
    );
  }

  Future<void> getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        state = state.copyWith(companies: listings, isLoading: false);
      },
      failure: (e) {
        state = state.copyWith(companies: [], isLoading: false);
      },
    );
  }
}

final companyListingsVmProvider =
    NotifierProvider<CompanyListingsViewModel, CompanyListingsState>(
      () => CompanyListingsViewModel(),
    );
