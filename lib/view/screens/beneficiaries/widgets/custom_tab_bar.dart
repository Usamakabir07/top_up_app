import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: MyColors.greyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelColor: MyColors.activeColor,
        indicatorColor: Colors.green,
        indicatorWeight: 0,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: MyColors.greyColor),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0,
        tabs: const [
          Tab(
            text: 'Recharge',
          ),
          Tab(text: 'History'),
        ],
      ),
    );
  }
}
