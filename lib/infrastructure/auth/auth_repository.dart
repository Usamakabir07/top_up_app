import 'package:dio/dio.dart';
import 'package:top_up_app/infrastructure/auth/api/login_api.dart';

import '../../common/prefs_keys.dart';
import '../apiUtil/response_wrappers.dart';
import 'auth_interface.dart';

class AuthRepository implements AuthInterface {
  AuthRepository({required this.loginApi});
  final LoginApi loginApi;

  @override
  Future<ResponseWrapper<dynamic>> login({
    required String email,
    required String password,
  }) async {
    Response response = await loginApi.login(
      email: email,
      password: password,
    );
    var res = ResponseWrapper<dynamic>();
    res.status = response.data[PrefsKeys.status];
    res.data = response.data[PrefsKeys.data];
    res.message = response.data[PrefsKeys.message];
    return res;
  }
}
