import 'package:dio/dio.dart';
import 'package:top_up_app/infrastructure/beneficiary/api/add_beneficiary_api.dart';

import '../../common/prefs_keys.dart';
import '../apiUtil/response_wrappers.dart';
import 'beneficiary_interface.dart';

class BeneficiaryRepository implements BeneficiaryInterface {
  BeneficiaryRepository({required this.addBeneficiaryApi});
  final AddBeneficiaryApi addBeneficiaryApi;

  @override
  Future<ResponseWrapper<dynamic>> addBeneficiary({
    required String nickName,
    required String phoneNumber,
  }) async {
    Response response = await addBeneficiaryApi.addBeneficiary(
        nickName: nickName, phoneNumber: phoneNumber);
    var res = ResponseWrapper<dynamic>();
    res.status = response.data[PrefsKeys.status];
    res.data = response.data[PrefsKeys.data];
    res.message = response.data[PrefsKeys.message];
    return res;
  }
}
