import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/utils/injections.dart';
import 'package:stock_app/core/utils/log/app_logger.dart';
import 'package:stock_app/core/utils/theme/theme.dart';
import 'package:stock_app/presentation/company_listings/view/company_listings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSettings();
  initRootLogger();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialTheme = MaterialTheme(
      ThemeData(useMaterial3: true).textTheme,
    );
    return MaterialApp(
      title: 'Stock App',
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: materialTheme.light().colorScheme.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: materialTheme.light().colorScheme.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          labelStyle: TextStyle(
            color: materialTheme.light().colorScheme.secondary,
          ),
        ),
      ),
      darkTheme: materialTheme.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: materialTheme.dark().colorScheme.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: materialTheme.dark().colorScheme.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          labelStyle: TextStyle(
            color: materialTheme.dark().colorScheme.secondary,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: CompanyListingsScreen(),
    );
  }
}
