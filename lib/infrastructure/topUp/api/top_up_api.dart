import 'package:dio/dio.dart';

import '../../apiUtil/urls.dart';

class TopUpApi {
  TopUpApi({required this.dio});

  final Dio dio;

  Future<dynamic> topUp({
    required String phoneNumber,
  }) async {
    final params = {
      'phone': phoneNumber,
    };
    Response response = await dio.post(
      Urls.topUpBeneficiary,
      data: params,
    );
    return response;
  }
}
