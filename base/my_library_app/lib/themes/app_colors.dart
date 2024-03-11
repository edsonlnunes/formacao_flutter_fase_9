import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? secondaryColor;

  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
    );
  }
}
