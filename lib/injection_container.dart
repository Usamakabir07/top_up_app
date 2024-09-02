import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:top_up_app/infrastructure/beneficiary/beneficiary_repository.dart';
import 'package:top_up_app/viewModels/auth_view_model.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';
import 'package:top_up_app/viewModels/top_up_view_model.dart';
import 'infrastructure/apiUtil/urls.dart';
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

registerApiCalls() {}

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
  serviceLocator.registerLazySingleton(() => DashboardRepository());
  serviceLocator.registerLazySingleton(() => BeneficiaryRepository());
}

registerCatalog() {
  serviceLocator.registerLazySingleton(() => CatalogFacadeService(
        homeRepository: serviceLocator(),
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
