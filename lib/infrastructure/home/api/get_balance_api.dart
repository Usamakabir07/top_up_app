import 'package:dio/dio.dart';

import '../../apiUtil/urls.dart';

class GetBalanceApi {
  GetBalanceApi({required this.dio});

  final Dio dio;

  Future<dynamic> getBalance() async {
    Response response = await dio.get(
      Urls.getBalance,
    );
    return response;
  }
}
