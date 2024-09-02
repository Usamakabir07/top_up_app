import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_up_app/infrastructure/home/api/get_balance_api.dart';

import '../../common/prefs_keys.dart';
import '../apiUtil/response_wrappers.dart';
import 'home_interface.dart';

class HomeRepository implements HomeInterface {
  HomeRepository({required this.getBalanceApi});
  final GetBalanceApi getBalanceApi;

  @override
  Future<ResponseWrapper<dynamic>> getBalance() async {
    Response response = await getBalanceApi.getBalance();
    var res = ResponseWrapper<dynamic>();
    res.status = response.data[PrefsKeys.status];
    res.data = response.data[PrefsKeys.data];
    res.message = response.data[PrefsKeys.message];
    return res;
  }
}
