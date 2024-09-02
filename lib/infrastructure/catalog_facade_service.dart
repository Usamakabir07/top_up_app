import 'package:top_up_app/infrastructure/auth/auth_repository.dart';
import 'package:top_up_app/infrastructure/beneficiary/beneficiary_repository.dart';
import 'package:top_up_app/infrastructure/topUp/top_up_repository.dart';

import 'apiUtil/response_wrappers.dart';
import 'home/home_repository.dart';

// This class is the medium between repositories
// and business logic which is provider in this case
// business model request data from the catalog
// and catalog redirect that request and retrieve
// that data and emitted back to business model

class CatalogFacadeService {
  const CatalogFacadeService({
    required this.authRepository,
    required this.homeRepository,
    required this.beneficiaryRepository,
    required this.topUpRepository,
  });

  final AuthRepository authRepository;
  final HomeRepository homeRepository;
  final BeneficiaryRepository beneficiaryRepository;
  final TopUpRepository topUpRepository;

  Future<ResponseWrapper<dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await authRepository.login(
      email: email,
      password: password,
    );
  }

  Future<ResponseWrapper<dynamic>> getBalance() async {
    return await homeRepository.getBalance();
  }

  Future<ResponseWrapper<dynamic>> addBeneficiary({
    required String nickName,
    required String phoneNumber,
  }) async {
    return await beneficiaryRepository.addBeneficiary(
      nickName: nickName,
      phoneNumber: phoneNumber,
    );
  }

  Future<ResponseWrapper<dynamic>> topUp({
    required String phoneNumber,
  }) async {
    return await topUpRepository.topUp(
      phoneNumber: phoneNumber,
    );
  }
}
