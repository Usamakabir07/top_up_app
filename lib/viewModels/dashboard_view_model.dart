import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/common/prefs_keys.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/utils/global_function.dart';
import 'package:top_up_app/utils/navigation_service.dart';
import 'package:top_up_app/view/screens/beneficiaries/beneficiaries_screen.dart';
import 'package:top_up_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:top_up_app/view/screens/home/home_screen.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';

import '../infrastructure/catalog_facade_service.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({
    required this.catalogFacadeService,
    required this.getStorage,
  }) {
    getStorage.initStorage;
    getTheBalance();
    getTheUsedBalance();
  }
  final CatalogFacadeService catalogFacadeService;
  final GetStorage getStorage;

  double _accountBalance = 0.0;
  double get accountBalance => _accountBalance;

  double _usedBalance = 0.0;
  double get usedBalance => _usedBalance;

  int _dashboardWidgetIndex = 0;
  int get dashboardWidgetIndex => _dashboardWidgetIndex;

  bool _isRecharging = false;
  bool get isRecharging => _isRecharging;

  final List<String> _promotionImages = const [
    "https://media.edenred.com/wp-content/uploads/2022/09/9d08c6a6aca6d28398bf6b4a2386ad76.png",
    "https://edenred.ae/wp-content/uploads/2021/12/1_Main-Banner-1.jpg",
    "https://www.edenred.com/sites/group/files/images/nos-engagements-rse-ideal_0.jpg",
  ];
  List<String> get promotionImages => _promotionImages;

  final List<Widget> _dashboardWidgets = [
    const HomeScreen(),
    const BeneficiariesScreen(),
    const Center(child: Text('Profile will appear here')),
  ];
  List<Widget> get dashboardWidgets => _dashboardWidgets;

  bool _addNewBeneficiary = false;
  bool get addNewBeneficiary => _addNewBeneficiary;

  void changeDashboardWidget(int index) {
    _dashboardWidgetIndex = index;
    notifyListeners();
  }

  void addANewBeneficiary(bool value) {
    _addNewBeneficiary = value;
    notifyListeners();
  }

  void getTheBalance() {

    ///Here is the code for HTTP call
    // catalogFacadeService.getBalance();

    if (getStorage.hasData(PrefsKeys.accountBalance)) {
      _accountBalance = getStorage.read(PrefsKeys.accountBalance);
      notifyListeners();
    } else {
      _accountBalance = 3000.67;
      getStorage.write(PrefsKeys.accountBalance, _accountBalance);
    }
    notifyListeners();
  }

  void getTheUsedBalance() {
    if (getStorage.hasData(PrefsKeys.balanceUsed)) {
      _usedBalance = getStorage.read(PrefsKeys.balanceUsed);
      notifyListeners();
    } else {
      _usedBalance = 0.00;
      getStorage.write(PrefsKeys.balanceUsed, _usedBalance);
    }
    notifyListeners();
  }

  void setNewBalance(double newBalance) async {
    _isRecharging = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    Beneficiary beneficiary = Provider.of<BeneficiaryViewModel>(
            NavigationService.navigatorKey.currentContext!,
            listen: false)
        .selectedBeneficiary;
    bool isAllowedForTransaction = Provider.of<BeneficiaryViewModel>(
            NavigationService.navigatorKey.currentContext!,
            listen: false)
        .updateBeneficiaryData(beneficiary, newBalance);
    if (newBalance > _accountBalance) {
      showToast(
        message: "You don't have sufficient balance to use this top-up option",
        context: NavigationService.navigatorKey.currentContext!,
      );
    } else if (!isAllowedForTransaction) {
      showToast(
        message:
            "${beneficiary.nickName} has already exceeded the monthly limit of AED 500",
        context: NavigationService.navigatorKey.currentContext!,
      );
    } else if (_usedBalance >= 3000) {
      showToast(
        message:
            "Sorry! You've reached the maximum monthly top-up limit of AED 3000",
        context: NavigationService.navigatorKey.currentContext!,
      );
    } else {
      _accountBalance = _accountBalance - newBalance;
      _usedBalance = _usedBalance + newBalance;
      getStorage.write(PrefsKeys.accountBalance, accountBalance);
      getStorage.write(PrefsKeys.balanceUsed, _usedBalance);
      _dashboardWidgetIndex = 0;
      Navigator.pushNamedAndRemoveUntil(
        NavigationService.navigatorKey.currentContext!,
        DashboardScreen.routeName,
        (Route<dynamic> route) => false,
      );
      showToast(
        message:
            "You've Recharged ${beneficiary.nickName} for AED ${(newBalance - 1).toStringAsFixed(2)}",
        context: NavigationService.navigatorKey.currentContext!,
      );
    }
    _isRecharging = false;
    notifyListeners();
  }
}
