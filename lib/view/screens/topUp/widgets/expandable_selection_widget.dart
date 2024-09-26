import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/view/screens/topUp/widgets/beneficiary_widget.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';

import '../../../../common/colors.dart';

class ExpandableSelectionWidget extends StatelessWidget {
  const ExpandableSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BeneficiaryViewModel>(
        builder: (context, beneficiaryViewModel, child) {
      return ExpandableNotifier(
        initialExpanded: false,
        child: ScrollOnExpand(
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              useInkWell: true,
              tapBodyToCollapse: true,
              tapHeaderToExpand: false,
              tapBodyToExpand: true,
              hasIcon: false,
            ),
            header: BeneficiaryWidget(
              beneficiary: beneficiaryViewModel.selectedBeneficiary,
              showTrailingButton: true,
            ),
            collapsed: const SizedBox(),
            expanded: Container(
              width: double.infinity,
              color: MyColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: beneficiaryViewModel.beneficiariesList
                        .where((beneficiary) =>
                            beneficiary.phone !=
                            beneficiaryViewModel.selectedBeneficiary.phone)
                        .map(
                          (beneficiary) => BeneficiaryWidget(
                            beneficiary: beneficiary,
                            showTrailingButton: false,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            builder: (_, collapsed, expanded) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class ExpandableIcon extends StatelessWidget {
  const ExpandableIcon({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    return ElevatedButton(
      onPressed: () {
        controller.toggle();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.activeColor,
        foregroundColor: MyColors.whiteColor,
      ),
      child: Text(
        controller!.expanded ? "Close" : "Change",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          // fontSize: 12,
        ),
      ),
    );
  }
}
