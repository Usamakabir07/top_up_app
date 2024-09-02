import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/common/colors.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/utils/global_function.dart';
import 'package:top_up_app/view/screens/beneficiaries/widgets/add_beneficiary_widget.dart';
import 'package:top_up_app/view/screens/beneficiaries/widgets/beneficiary_card.dart';
import 'package:top_up_app/view/screens/beneficiaries/widgets/custom_tab_bar.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';

class BeneficiariesScreen extends StatefulWidget {
  static const String routeName = '/beneficiaries-screen';
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mobile Recharge",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          CustomTabBar(tabController: tabController),
          const SizedBox(height: 5),
          Expanded(
            child: Consumer<BeneficiaryViewModel>(
                builder: (context, beneficiaryViewModel, child) {
              return TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Beneficiaries",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (beneficiaryViewModel
                                        .beneficiariesList.length <
                                    5) {
                                  beneficiaryViewModel.addANewBeneficiary(true);
                                  // showBeneficiaryBottomSheet(context);
                                } else {
                                  showToast(
                                    message:
                                        "You cannot register more than 5 beneficiaries",
                                    context: context,
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: MyColors.activeColor,
                                padding: EdgeInsets.zero,
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                  ),
                                  Text(
                                    "Add Beneficiary",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Consumer<BeneficiaryViewModel>(
                            builder: (context, beneficiaryViewModel, child) {
                          return beneficiaryViewModel.addNewBeneficiary &&
                                  beneficiaryViewModel.beneficiariesList.isEmpty
                              ? const AddBeneficiaryWidget()
                              : SizedBox(
                                  height: 160,
                                  child: beneficiaryViewModel
                                          .beneficiariesList.isEmpty
                                      ? Center(
                                          child: Text(
                                            "Add Beneficiaries to recharge the phone numbers",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: MyColors.greyColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: beneficiaryViewModel
                                              .beneficiariesList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            Beneficiary beneficiary =
                                                beneficiaryViewModel
                                                    .beneficiariesList[index];
                                            return BeneficiaryCard(
                                              beneficiary: beneficiary,
                                            );
                                          },
                                        ),
                                );
                        }),
                        if (beneficiaryViewModel.addNewBeneficiary &&
                            beneficiaryViewModel.beneficiariesList.isNotEmpty)
                          const AddBeneficiaryWidget(),
                      ],
                    ),
                  ),
                  const Center(child: Text('History will appear here')),
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
