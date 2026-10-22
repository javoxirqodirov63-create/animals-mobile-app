import 'package:flutter/material.dart';
import '../core/theme/design_variant.dart';

class ThemeProvider with ChangeNotifier {
  AppDesignVariant _currentVariant = AppDesignVariant.cyberNeon;

  AppDesignVariant get currentVariant => _currentVariant;
  DesignThemeConfig get config => DesignThemeConfig.of(_currentVariant);

  void setVariant(AppDesignVariant variant) {
    if (_currentVariant != variant) {
      _currentVariant = variant;
      notifyListeners();
    }
  }
}
