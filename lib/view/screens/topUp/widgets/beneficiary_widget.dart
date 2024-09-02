import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';

import '../../../../common/colors.dart';
import 'expandable_selection_widget.dart';

class BeneficiaryWidget extends StatelessWidget {
  const BeneficiaryWidget({
    super.key,
    required this.beneficiary,
    required this.showTrailingButton,
  });
  final Beneficiary beneficiary;
  final bool showTrailingButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!showTrailingButton) {
          context
              .read<BeneficiaryViewModel>()
              .selectNewBeneficiary(beneficiary);
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_2,
                    color: MyColors.activeColor,
                    size: 40,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          beneficiary.nickName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        beneficiary.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.greyColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              if (showTrailingButton) const ExpandableIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
