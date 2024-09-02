import 'package:flutter/material.dart';
import 'package:top_up_app/view/screens/beneficiaries/widgets/add_beneficiary_widget.dart';

import '../../common/colors.dart';

int walletPoints = 120; // Example points, you can change this value

void showBeneficiaryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: MyColors.whiteColor,
    isScrollControlled: true,
    constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.5,
        maxHeight: MediaQuery.of(context).size.height * 0.6),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        child: const AddBeneficiaryWidget(),
      );
    },
  );
}
