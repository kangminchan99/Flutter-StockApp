// DB에 접근하는 기능들을 모아놓은 클래스
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/core/utils/constant/config.dart';
import 'package:stock_app/data/src/local/company_listing_entity.dart';

class StockDao {
  final box = Hive.box(Config.companyListingBoxName);

  // 데이터 추가
  Future<void> insertCompanyListings(
    List<CompanyListingEntity> companyListingEntitys,
  ) async {
    await box.addAll(companyListingEntitys);
  }

  // 캐시 데이터 삭제
  Future<void> clearCompanyListings() async {
    await box.clear();
  }

  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    // 박스에 개별 엔티티가 들어있는 경우
    final companyListing = box.values.cast<CompanyListingEntity>().toList();

    final q = query.trim();
    if (q.isEmpty) return [];

    final qLower = q.toLowerCase();
    final qUpper = q.toUpperCase();

    return companyListing
        .where(
          (e) =>
              e.name.isNotEmpty && e.symbol.isNotEmpty && e.exchange.isNotEmpty,
        )
        .where(
          (e) =>
              e.name.toLowerCase().contains(qLower) ||
              e.symbol.toUpperCase() == qUpper,
        )
        .toList();
  }
}

final stockDaoProvider = Provider<StockDao>((ref) {
  return StockDao();
});
