import '../apiUtil/response_wrappers.dart';

abstract class BeneficiaryInterface {
  Future<ResponseWrapper<dynamic>> addBeneficiary({
    required String nickName,
    required String phoneNumber,
  });
}
