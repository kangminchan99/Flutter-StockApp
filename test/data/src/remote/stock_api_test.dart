import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_app/core/utils/constant/config.dart';
import 'package:stock_app/core/utils/constant/network_constant.dart';
import 'package:stock_app/core/utils/log/app_logger.dart';
import 'package:stock_app/data/csv/company_listings_parser.dart';
import 'package:stock_app/data/src/remote/stock_api.dart';

import '../../../dummy.dart';
import 'stock_api_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDio mockDio;

  setUp(() async {
    mockDio = MockDio();
    initRootLogger();
    await dotenv.load(fileName: ".env");
  });

  group('Stock Api Test', () {
    test('네트워크 통신', () async {
      final parser = CompanyListingsParser();

      when(mockDio.get(getListingsPath())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: Dummy.dummyList,
        ),
      );

      final response = await StockApi(
        dio: mockDio,
      ).getListing(Config.stockApiKey);

      final remoteListings = await parser.parse(response.data);

      expect(remoteListings[0].symbol, 'A');
      expect(remoteListings[0].name, 'Agilent Technologies Inc');
      expect(remoteListings[0].exchange, 'NYSE');
    });
  });
}
