import 'package:dio/dio.dart';

import '../../apiUtil/urls.dart';

class AddBeneficiaryApi {
  AddBeneficiaryApi({required this.dio});

  final Dio dio;

  Future<dynamic> addBeneficiary({
    required String nickName,
    required String phoneNumber,
  }) async {
    final params = {
      'nick_name': nickName,
      'phone': phoneNumber,
    };
    Response response = await dio.post(
      Urls.addBeneficiary,
      data: params,
    );
    return response;
  }
}
