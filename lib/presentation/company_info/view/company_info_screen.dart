import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/domain/model/company_info_model.dart';
import 'package:stock_app/presentation/company_info/view_model/company_info_view_model.dart';

class CompanyInfoScreen extends ConsumerWidget {
  final String symbol;
  const CompanyInfoScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(companyInfoVmProvider(symbol));
    final vmNoti = ref.read(companyInfoVmProvider(symbol).notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            if (vm.errorMsg != null) Center(child: Text(vm.errorMsg!)),

            if (vm.isLoading)
              const Center(child: CircularProgressIndicator.adaptive()),

            if (vm.information?.isNotEmpty ?? false) Text(vm.information!),

            if (vm.isLoading == false &&
                vm.errorMsg == null &&
                vm.company != null)
              _buildBody(vm.company!),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(CompanyInfoModel companyInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            companyInfo.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            companyInfo.symbol,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          const Divider(),
          Text('Industry: ${companyInfo.industry}'),
          Text('Country: ${companyInfo.country}'),
          const Divider(),
          Text(companyInfo.description, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
