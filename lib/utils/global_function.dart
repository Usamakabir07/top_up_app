import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common/prefs_keys.dart';
import 'navigation_service.dart';

showToast({required String message, required BuildContext context}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}

void handleDioError(DioException e) {
  e.type == DioExceptionType.connectionError
      ? showToast(
          message:
              "Something went wrong!\nPlease check your internet connection",
          context: NavigationService.navigatorKey.currentContext!,
        )
      : e.response == null
          ? showToast(
              message:
                  "Connection error\n Please check your internet connection",
              context: NavigationService.navigatorKey.currentContext!,
            )
          : e.response!.statusCode == 500
              ? showToast(
                  message: 'Server Error',
                  context: NavigationService.navigatorKey.currentContext!)
              : e.response != null &&
                      e.response?.data != null &&
                      e.response?.data != '' &&
                      e.response!.statusCode != 400 &&
                      e.response!.statusCode != 401
                  ? showToast(
                      message:
                          e.response?.data[PrefsKeys.data] ?? e.response?.data,
                      context: NavigationService.navigatorKey.currentContext!)
                  : showToast(
                      message:
                          "Connection error\n Please check your internet connection",
                      context: NavigationService.navigatorKey.currentContext!,
                    );
}

bool checkBalanceValidity() {
  bool resetTheBalance = false;
  DateTime now = DateTime.now();
  int currentMonth = now.month; // Current month
  int currentYear = now.year;
  if (now.month != currentMonth || now.year != currentYear) {
    currentMonth = now.month;
    currentYear = now.year;
    resetTheBalance = true;
  }
  return resetTheBalance;
}
