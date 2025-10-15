import 'package:dio/dio.dart';
import 'package:stock_app/core/network/error/dio_error_handler.dart';
import 'package:stock_app/core/network/error/exceptions.dart';
import 'package:stock_app/core/network/result.dart';
import 'package:stock_app/core/utils/constant/config.dart';
import 'package:stock_app/data/csv/company_listings_parser.dart';
import 'package:stock_app/data/mapper/company_mapper.dart';
import 'package:stock_app/data/src/local/stock_dao.dart';
import 'package:stock_app/data/src/remote/stock_api.dart';
import 'package:stock_app/domain/model/company_info_model.dart';
import 'package:stock_app/domain/model/company_listing_model.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  // remote에서 접근
  final StockApi _api;
  // local에서 접근
  final StockDao _dao;

  final _parser = CompanyListingsParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListingModel>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  ) async {
    // 캐시에서 찾는다
    final localListings = await _dao.searchCompanyListing(query);

    // 없으면 리모트에서 가져온다.
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    // 캐시에서 가지고 와야하는지 확인
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // 캐시
    if (shouldJustLoadFromCache) {
      return Result.success(
        localListings.map((e) => e.toCompanyListing()).toList(),
      );
    }

    // remote
    try {
      final response = await _api.getListing(Config.stockApiKey);
      final remoteListings = await _parser.parse(response.data);

      // 캐시 비우기
      await _dao.clearCompanyListings();

      // 캐시 추가
      await _dao.insertCompanyListings(
        remoteListings.map((e) => e.toCompanyListingEntity()).toList(),
      );

      return Result.success(remoteListings);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<Result<CompanyInfoModel>> getCompanyInfo(String symbol) async {
    try {
      final dto = await _api.getCompanyInfo(Config.stockApiKey, symbol: symbol);

      return Result.success(dto.toCompanyInfoModel());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
