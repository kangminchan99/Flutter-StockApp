import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_listings/view_model/company_listings_view_model.dart';

import '../../domain/repository/stock_repository_test.dart';

void main() {
  test('뷰모델만 가져와 로딩/데이터 검증', () async {
    final container = ProviderContainer(
      overrides: [
        // 실제 Repo 대신 가짜로 교체
        stockRepositoryProvider.overrideWithValue(FakeStockRepository()),
      ],
    );
    addTearDown(container.dispose);

    // 뷰모델만 받아옴 (UI 없이)
    final vm = container.read(companyListingsVmProvider.notifier);

    //  메서드 호출
    await vm.getCompanyListings();

    // 최종 상태 확인
    final state = container.read(companyListingsVmProvider);
    expect(state.isLoading, false);
    expect(state.companies, isNotEmpty);
    expect(state.companies.first.symbol, 'A');
  });
}
