import '../apiUtil/response_wrappers.dart';

abstract class AuthInterface {
  Future<ResponseWrapper<dynamic>> login({
    required String email,
    required String password,
  });
}
