import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/view/screens/dashboard/widgets/custom_app_bar.dart';
import 'package:top_up_app/view/screens/dashboard/widgets/custom_bottom_bar.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      appBar: customAppBar(),
      body: Consumer<DashboardViewModel>(
          builder: (context, dashboardViewModel, _) {
        return dashboardViewModel
            .dashboardWidgets[dashboardViewModel.dashboardWidgetIndex];
      }),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
