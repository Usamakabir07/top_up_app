import 'package:flutter/material.dart';

import '../../../../common/colors.dart';
import '../../../../common/images.dart';

PreferredSize customAppBar() {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 70),
    child: AppBar(
      title: Image.asset(
        AppImages.appLogo2,
        height: 60,
        width: 60,
        fit: BoxFit.contain,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.person,
            color: MyColors.activeColor,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
