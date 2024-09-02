import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_up_app/common/prefs_keys.dart';
import 'package:top_up_app/infrastructure/beneficiary/model/beneficiary_model.dart';
import 'package:top_up_app/utils/global_function.dart';
import 'package:top_up_app/utils/navigation_service.dart';

import '../infrastructure/catalog_facade_service.dart';

class BeneficiaryViewModel extends ChangeNotifier {
  BeneficiaryViewModel({
    required this.catalogFacadeService,
    required this.getStorage,
  }) {
    getTheBeneficiaries();
  }
  final CatalogFacadeService catalogFacadeService;
  final GetStorage getStorage;

  bool _addNewBeneficiary = false;
  bool get addNewBeneficiary => _addNewBeneficiary;

  bool _isRegisteringNewBeneficiary = false;
  bool get isRegisteringNewBeneficiary => _isRegisteringNewBeneficiary;

  List<Beneficiary> _beneficiariesList = [
    Beneficiary(
      nickName: "Usama Kabir",
      phone: "+971554774180",
      balanceUsed: 0.0,
    ),
  ];
  List<Beneficiary> get beneficiariesList => _beneficiariesList;

  Beneficiary _selectedBeneficiary = Beneficiary(
    nickName: "",
    phone: "",
    balanceUsed: 0.0,
  );
  Beneficiary get selectedBeneficiary => _selectedBeneficiary;

  void addANewBeneficiary(bool value) {
    _addNewBeneficiary = value;
    notifyListeners();
  }

  void selectNewBeneficiary(Beneficiary beneficiary) {
    _selectedBeneficiary = beneficiary;
    notifyListeners();
  }

  void registerBeneficiary({
    required String beneficiaryName,
    required String countryCode,
    required String phoneNumber,
  }) async {
    try {
      _isRegisteringNewBeneficiary = true;
      notifyListeners();
      Beneficiary beneficiary = Beneficiary(
        nickName: beneficiaryName,
        phone: countryCode + phoneNumber,
        balanceUsed: 0.0,
      );

      ///Here is the code for HTTP call
      // catalogFacadeService.addBeneficiary(nickName: beneficiaryName, phoneNumber: phoneNumber);
      await Future.delayed(const Duration(seconds: 2));
      if (_beneficiariesList
          .any(((element) => element.phone != beneficiary.phone))) {
        _beneficiariesList.insert(0, beneficiary);
        showToast(
          message: "Beneficiary is added",
          context: NavigationService.navigatorKey.currentContext!,
        );
        getStorage.write(PrefsKeys.beneficiaries, _beneficiariesList);
      } else {
        showToast(
          message: "A beneficiary is already registered with this number",
          context: NavigationService.navigatorKey.currentContext!,
        );
      }
      notifyListeners();
    } on DioException catch (e) {
      showToast(
        message: "Something went wrong! \n$e",
        context: NavigationService.navigatorKey.currentContext!,
      );
    } catch (e) {
      showToast(
        message: "Something went wrong! \n$e",
        context: NavigationService.navigatorKey.currentContext!,
      );
    }
    _isRegisteringNewBeneficiary = false;
    _addNewBeneficiary = false;
    notifyListeners();
  }

  void getTheBeneficiaries() {
    if (getStorage.hasData(PrefsKeys.beneficiaries)) {
      List<dynamic> beneficiaries = getStorage.read(PrefsKeys.beneficiaries);
      List<Beneficiary> storedBeneficiaries =
          beneficiaries.map((user) => Beneficiary.fromJson(user)).toList();
      _beneficiariesList = storedBeneficiaries;
    } else {
      List<Map<String, dynamic>> beneficiaries = _beneficiariesList
          .map((beneficiary) => beneficiary.toJson())
          .toList();
      getStorage.write(PrefsKeys.beneficiaries, beneficiaries);
    }
    notifyListeners();
  }

  bool updateBeneficiaryData(Beneficiary beneficiary, double balanceUsed) {
    bool isAllowedForTransaction = false;
    Beneficiary updatedBeneficiary = Beneficiary(
      nickName: beneficiary.nickName,
      phone: beneficiary.phone,
      balanceUsed: beneficiary.balanceUsed + balanceUsed,
    );
    int index = _beneficiariesList.indexWhere(
        (beneficiary) => beneficiary.phone == updatedBeneficiary.phone);
    if (index != -1) {
      _beneficiariesList[index] = updatedBeneficiary;
      if (_beneficiariesList[index].balanceUsed <= 505.00) {
        List<Map<String, dynamic>> beneficiaries = _beneficiariesList
            .map((beneficiary) => beneficiary.toJson())
            .toList();
        getStorage.write(PrefsKeys.beneficiaries, beneficiaries);
        isAllowedForTransaction = true;
      } else {
        isAllowedForTransaction = false;
      }
    }
    notifyListeners();
    return isAllowedForTransaction;
  }
}
