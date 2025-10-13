import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get stockBaseUrl => dotenv.env['STOCK_BASE_URL'] ?? '';
  static String get stockApiKey => dotenv.env['STOCK_API_KEY'] ?? '';
  static const String companyListing = 'companyListing';
}
