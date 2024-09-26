import 'package:flutter/material.dart';
import '../../common/colors.dart';

class WidgetDialog extends StatelessWidget {
  const WidgetDialog({
    super.key,
    required this.content,
    required this.confirmFunction,
    required this.title,
    required this.confirmText,
  });
  final String title;
  final Widget content;
  final Function confirmFunction;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Wrap(
        spacing: 10,
        children: [
          Icon(
            Icons.info,
            color: MyColors.activeColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: MyColors.activeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
        ],
      ),
      content: content,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.greyColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: MyColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => confirmFunction(),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.activeColor,
          ),
          child: Text(
            confirmText,
            style: TextStyle(
              color: MyColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
