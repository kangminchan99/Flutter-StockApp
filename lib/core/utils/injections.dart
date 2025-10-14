import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/data/src/local/company_listing_entity_adapter.dart';

Future<void> initSettings() async {
  await dotenv.load(fileName: ".env");
  Hive.registerAdapter(CompanyListingEntityAdapter());
}
