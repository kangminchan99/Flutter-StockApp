import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/core/network/dio_network.dart';
import 'package:stock_app/core/utils/log/app_logger.dart';
import 'package:stock_app/data/src/local/company_listing_entity_adapter.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await dotenv.load(fileName: ".env");
  await initDioInjections();
  Hive.registerAdapter(CompanyListingEntityAdapter());
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
