import '../apiUtil/response_wrappers.dart';

abstract class TopUpInterface {
  Future<ResponseWrapper<dynamic>> topUp({
    required String phoneNumber,
  });
}
