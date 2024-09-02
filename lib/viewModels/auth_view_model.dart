import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_up_app/common/prefs_keys.dart';
import 'package:top_up_app/utils/navigation_service.dart';

import '../infrastructure/catalog_facade_service.dart';
import '../view/screens/dashboard/dashboard_screen.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel({required this.catalogFacadeService, required this.getStorage});
  final CatalogFacadeService catalogFacadeService;
  final GetStorage getStorage;

  void navigateToTheDashboard(bool isNavigated) {
    getStorage.write(PrefsKeys.isVerified, isNavigated);
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(
      NavigationService.navigatorKey.currentContext!,
      DashboardScreen.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
