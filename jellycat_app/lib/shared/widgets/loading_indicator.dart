import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Custom loading indicator with Jellycat branding
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBrand),
      ),
    );
  }
}
