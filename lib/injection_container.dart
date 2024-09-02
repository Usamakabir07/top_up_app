import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:top_up_app/infrastructure/auth/auth_repository.dart';
import 'package:top_up_app/infrastructure/beneficiary/api/add_beneficiary_api.dart';
import 'package:top_up_app/infrastructure/beneficiary/beneficiary_repository.dart';
import 'package:top_up_app/infrastructure/home/api/get_balance_api.dart';
import 'package:top_up_app/infrastructure/topUp/api/top_up_api.dart';
import 'package:top_up_app/infrastructure/topUp/top_up_repository.dart';
import 'package:top_up_app/viewModels/auth_view_model.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';
import 'package:top_up_app/viewModels/top_up_view_model.dart';
import 'infrastructure/apiUtil/urls.dart';
import 'infrastructure/auth/api/login_api.dart';
import 'infrastructure/catalog_facade_service.dart';
import 'infrastructure/home/home_repository.dart';
import 'package:get_storage/get_storage.dart';

final GetIt serviceLocator = GetIt.instance;

// register all components to get it to inject the dependencies where we need it
Future<void> init() async {
  //core
  await registerCoreComponents();

  //catalog
  registerCatalog();

  //viewModel
  registerViewModel();

  //repository
  registerRepository();

  //ApiCall
  registerApiCalls();
}

registerApiCalls() {
  serviceLocator.registerLazySingleton(() => LoginApi(
        dio: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => GetBalanceApi(
        dio: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => AddBeneficiaryApi(
        dio: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => TopUpApi(
        dio: serviceLocator(),
      ));
}

registerViewModel() {
  serviceLocator.registerLazySingleton(() => AuthViewModel(
        catalogFacadeService: serviceLocator(),
        getStorage: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => DashboardViewModel(
        catalogFacadeService: serviceLocator(),
        getStorage: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => BeneficiaryViewModel(
        catalogFacadeService: serviceLocator(),
        getStorage: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => TopUpViewModel(
        catalogFacadeService: serviceLocator(),
        getStorage: serviceLocator(),
      ));
}

registerRepository() {
  serviceLocator.registerLazySingleton(() => AuthRepository(
        loginApi: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => HomeRepository(
        getBalanceApi: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => BeneficiaryRepository(
        addBeneficiaryApi: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => TopUpRepository(
        topUpApi: serviceLocator(),
      ));
}

registerCatalog() {
  serviceLocator.registerLazySingleton(() => CatalogFacadeService(
        homeRepository: serviceLocator(),
        authRepository: serviceLocator(),
        beneficiaryRepository: serviceLocator(),
        topUpRepository: serviceLocator(),
      ));
}

registerCoreComponents() async {
  GetStorage localStorage = GetStorage();
  serviceLocator.registerLazySingleton(() => localStorage);
  serviceLocator.registerLazySingleton(() => getNetworkObj());
}

Dio getNetworkObj() {
  BaseOptions options = BaseOptions(
    baseUrl: Urls.kBaseUrl,
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 30000),
  );
  Dio dio = Dio(options);

  //intercept every api request and add needed headers to it
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Accept'] = '*/*';
        options.headers['Access-Control-Allow-Origin'] = '*';

        handler.next(options);
      },
    ),
  );

  //dio logger to see every request and response
  //on the debug console, remove on release!!!
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 120,
  ));
  return dio;
}
