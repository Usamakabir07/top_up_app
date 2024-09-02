import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/route_generator.dart';
import 'package:top_up_app/utils/navigation_service.dart';
import 'package:top_up_app/view/screens/auth/login_screen.dart';
import 'package:top_up_app/viewModels/auth_view_model.dart';
import 'package:top_up_app/viewModels/beneficiary_view_model.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';
import 'package:top_up_app/viewModels/top_up_view_model.dart';
import 'injection_container.dart' as di;

import 'common/themes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  di.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => di.serviceLocator<AuthViewModel>(),
          ),
          ChangeNotifierProvider(
            create: (context) => di.serviceLocator<DashboardViewModel>(),
          ),
          ChangeNotifierProvider(
            create: (context) => di.serviceLocator<BeneficiaryViewModel>(),
          ),
          ChangeNotifierProvider(
            create: (context) => di.serviceLocator<TopUpViewModel>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          title: 'Top-Up',
          debugShowCheckedModeBanner: false,
          theme: Themes.brightTheme(context).copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
          //generate routes using the route generator class
          onGenerateRoute: RouteGenerator.generateRoute,
          onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (_) => const LoginScreen(), settings: settings),
        ),
      ),
    );
  }
}
