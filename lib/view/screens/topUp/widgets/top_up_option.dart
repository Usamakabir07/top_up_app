import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/utils/global_function.dart';
import 'package:top_up_app/viewModels/top_up_view_model.dart';

import '../../../../common/colors.dart';

class TopUpOption extends StatelessWidget {
  const TopUpOption(
      {super.key, required this.topUpOption, required this.index});
  final double topUpOption;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopUpViewModel>(builder: (context, topUpViewModel, child) {
      return Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: topUpViewModel.selectedOptionIndex == index ? 4 : 0,
                color: MyColors.appDark,
              ),
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                MyColors.activeColor,
                MyColors.activeColor.withOpacity(0.8),
                MyColors.activeColor
              ])),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "AED",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: MyColors.whiteColor),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: MyColors.whiteColor,
                    ),
                    children: [
                      TextSpan(
                        text: topUpOption.toString().split(".")[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ".${topUpOption.toStringAsFixed(2).split(".")[1]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (topUpViewModel.selectedOptionIndex != index) {
                      topUpViewModel.selectTheTopUpOption(index);
                    } else {
                      showToast(
                        message: "This top-up option is already selected",
                        context: context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.whiteColor,
                    foregroundColor: MyColors.activeColor,
                  ),
                  child: Text(
                    topUpViewModel.selectedOptionIndex == index
                        ? "Selected"
                        : "Select",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
