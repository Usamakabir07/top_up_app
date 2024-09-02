import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/colors.dart';
import '../../../../viewModels/dashboard_view_model.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    double kWidth = MediaQuery.of(context).size.width;
    return Consumer<DashboardViewModel>(
      builder: (context, homeViewModel, child) {
        return Container(
          height: 65,
          width: kWidth,
          color: MyColors.whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
        );
      },
    );
  }
}
