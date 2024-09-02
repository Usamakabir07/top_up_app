import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';

import '../../../../common/colors.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, child) {
        return BottomNavigationBar(
          onTap: (index) {
            dashboardViewModel.changeDashboardWidget(index);
          },
          selectedItemColor: MyColors.activeColor,
          unselectedItemColor: MyColors.greyColor,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home_rounded,
                color: MyColors.activeColor,
              ),
            ),
            BottomNavigationBarItem(
              label: "Recharge",
              icon: Icon(
                Icons.charging_station,
                color: MyColors.activeColor,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person,
                color: MyColors.activeColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
