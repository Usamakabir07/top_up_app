import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/viewModels/dashboard_view_model.dart';

class PromotionWidget extends StatelessWidget {
  const PromotionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
        builder: (context, dashboardViewModel, _) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: dashboardViewModel.promotionImages.length,
          itemBuilder: (context, index) {
            String image = dashboardViewModel.promotionImages[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 0),
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}
