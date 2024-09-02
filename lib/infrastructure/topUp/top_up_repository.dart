import 'package:dio/dio.dart';
import 'package:top_up_app/infrastructure/topUp/api/top_up_api.dart';

import '../../common/prefs_keys.dart';
import '../apiUtil/response_wrappers.dart';
import 'top_up_interface.dart';

class TopUpRepository implements TopUpInterface {
  TopUpRepository({required this.topUpApi});
  final TopUpApi topUpApi;

  @override
  Future<ResponseWrapper<dynamic>> topUp({
    required String phoneNumber,
  }) async {
    Response response = await topUpApi.topUp(
      phoneNumber: phoneNumber,
    );
    var res = ResponseWrapper<dynamic>();
    res.status = response.data[PrefsKeys.status];
    res.data = response.data[PrefsKeys.data];
    res.message = response.data[PrefsKeys.message];
    return res;
  }
}
