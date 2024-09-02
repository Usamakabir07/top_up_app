import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../infrastructure/catalog_facade_service.dart';

class TopUpViewModel extends ChangeNotifier {
  TopUpViewModel(
      {required this.catalogFacadeService, required this.getStorage});
  final CatalogFacadeService catalogFacadeService;
  final GetStorage getStorage;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  int _selectedOptionIndex = -1;
  int get selectedOptionIndex => _selectedOptionIndex;

  final List<double> _topUpOptions = [
    5.00,
    10.00,
    20.00,
    30.00,
    50.00,
    100.00,
  ];
  List<double> get topUpOptions => _topUpOptions;

  void selectTheTopUpOption(int index) {
    if (scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
    _selectedOptionIndex = index;
    notifyListeners();
  }

  void resetTheValues() {
    _selectedOptionIndex = -1;
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
