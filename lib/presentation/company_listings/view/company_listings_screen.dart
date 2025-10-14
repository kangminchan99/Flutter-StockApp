import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/presentation/company_listings/company_listings_view_model.dart';

class CompanyListingsScreen extends ConsumerWidget {
  const CompanyListingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(companyListingsVmProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(decoration: InputDecoration(labelText: '검색..')),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: vm.companies.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(title: Text(vm.companies[index].name)),
                        Divider(color: Theme.of(context).colorScheme.secondary),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
