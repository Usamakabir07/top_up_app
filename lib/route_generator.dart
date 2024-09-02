import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/view/screens/auth/login_screen.dart';
import 'package:top_up_app/view/screens/beneficiaries/beneficiaries_screen.dart';
import 'package:top_up_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:top_up_app/view/screens/home/home_screen.dart';
import 'package:top_up_app/view/screens/topUp/top_up_screen.dart';

import 'common/prefs_keys.dart';
import 'injection_container.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    final GetStorage getStorage = serviceLocator<GetStorage>();
    final Widget view;
    final bool isVerified = getStorage.hasData(PrefsKeys.isVerified);
    switch (settings.name) {
      case LoginScreen.routeName:
        view = const LoginScreen();
        break;
      case HomeScreen.routeName:
        view = const HomeScreen();
        break;
      case BeneficiariesScreen.routeName:
        view = const BeneficiariesScreen();
        break;
      case TopUpScreen.routeName:
        view = TopUpScreen(
          beneficiaryDetail: Beneficiary(
            nickName: "",
            phone: "",
            balanceUsed: 0.0,
          ),
        );
        break;
      case DashboardScreen.routeName:
        view = const DashboardScreen();
        break;
      default:
        view = isVerified ? const DashboardScreen() : const LoginScreen();
    }
    return MaterialPageRoute(builder: (_) => view, settings: settings);
  }
}
