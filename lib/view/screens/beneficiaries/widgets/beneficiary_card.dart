import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/view/commonWidgets/widget_dialog.dart';
import 'package:top_up_app/view/screens/topUp/top_up_screen.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';

import '../../../../common/colors.dart';

class BeneficiaryCard extends StatelessWidget {
  const BeneficiaryCard({super.key, required this.beneficiary});
  final Beneficiary beneficiary;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => WidgetDialog(
            content:
                Text("Do you really want to remove ${beneficiary.nickName}?"),
            confirmFunction: () {
              Navigator.pop(context);
              return context.read<BeneficiaryViewModel>().removeBeneficiary(
                    beneficiaryId: beneficiary.phone,
                  );
            },
            title: "Confirmation",
            confirmText: "Remove",
          ),
        );
      },
      child: Card(
        color: MyColors.whiteColor,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  beneficiary.nickName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                beneficiary.phone,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.greyColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<BeneficiaryViewModel>()
                      .selectNewBeneficiary(beneficiary);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpScreen(
                        beneficiaryDetail: beneficiary,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.activeColor,
                  foregroundColor: MyColors.whiteColor,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: const Text(
                  "Recharge now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
