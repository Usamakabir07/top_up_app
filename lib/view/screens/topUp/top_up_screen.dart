import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/view/screens/dashboard/widgets/custom_app_bar.dart';
import 'package:top_up_app/view/screens/topUp/widgets/expandable_selection_widget.dart';
import 'package:top_up_app/view/screens/topUp/widgets/top_up_option.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';
import 'package:top_up_app/viewModels/top_up_view_model.dart';

import '../../../common/colors.dart';

class TopUpScreen extends StatelessWidget {
  static const String routeName = '/top-up';
  const TopUpScreen({super.key, required this.beneficiaryDetail});
  final Beneficiary beneficiaryDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            Consumer<TopUpViewModel>(builder: (context, topUpViewModel, child) {
          return SingleChildScrollView(
            controller: topUpViewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Top Up Options",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Beneficiary Detail",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                const ExpandableSelectionWidget(),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  "Select available top-up options",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 170,
                  child: ListView.builder(
                      itemCount: topUpViewModel.topUpOptions.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TopUpOption(
                          topUpOption: topUpViewModel.topUpOptions[index],
                          index: index,
                        );
                      }),
                ),
                const SizedBox(height: 10),
                if (topUpViewModel.selectedOptionIndex > -1)
                  context.watch<DashboardViewModel>().isRecharging
                      ? Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              CircularProgressIndicator(
                                color: MyColors.activeColor,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Recharging..",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const SizedBox(height: 10),
                            const Text(
                              "Payment",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Available Balance",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "AED ${context.watch<DashboardViewModel>().accountBalance}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Top-up option selected",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "AED ${topUpViewModel.topUpOptions[topUpViewModel.selectedOptionIndex]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaction fee",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "AED 1.00",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Grand total",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "AED ${(topUpViewModel.topUpOptions[topUpViewModel.selectedOptionIndex] + 1).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    double newBalance =
                                        topUpViewModel.topUpOptions[
                                                topUpViewModel
                                                    .selectedOptionIndex] +
                                            1;
                                    context
                                        .read<DashboardViewModel>()
                                        .setNewBalance(newBalance);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.activeColor,
                                    foregroundColor: MyColors.whiteColor,
                                  ),
                                  child: const Text(
                                    "Top up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
