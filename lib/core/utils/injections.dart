import 'package:get_it/get_it.dart';
import 'package:stock_app/core/network/dio_network.dart';
import 'package:stock_app/core/utils/log/app_logger.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initDioInjections();
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
