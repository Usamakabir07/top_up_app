import '../apiUtil/response_wrappers.dart';

abstract class HomeInterface {
  Future<ResponseWrapper<dynamic>> getBalance();
}
