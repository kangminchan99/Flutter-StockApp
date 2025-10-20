import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';
import 'package:stock_app/presentation/company_info/components/stock_chart.dart';
import 'package:stock_app/presentation/company_info/view_model/company_info_view_model.dart';

class CompanyInfoScreen extends ConsumerWidget {
  final String symbol;
  const CompanyInfoScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(companyInfoVmProvider(symbol));
    // final vmNoti = ref.read(companyInfoVmProvider(symbol).notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              if (vm.errorMsg != null) Center(child: Text(vm.errorMsg!)),

              if (vm.isLoading)
                const Center(child: CircularProgressIndicator.adaptive()),

              if (vm.information?.isNotEmpty ?? false) Text(vm.information!),

              if (vm.isLoading == false &&
                  vm.errorMsg == null &&
                  vm.company != null)
                _buildBody(vm, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CompanyInfoState vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vm.company!.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            vm.company!.symbol,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          const Divider(),
          Text('Industry: ${vm.company!.industry}'),
          Text('Country: ${vm.company!.country}'),
          const Divider(),
          Text(vm.company!.description, style: TextStyle(fontSize: 12)),
          const SizedBox(height: 16),
          const Text(
            'Market Summary',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (vm.stockInfos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StockChart(
                infos: vm.stockInfos,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
