import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Filter chip for collections
class CollectionFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const CollectionFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.primaryBrand.withOpacity(0.2),
      checkmarkColor: AppColors.primaryBrand,
      labelStyle: AppTextStyles.labelMedium.copyWith(
        color: isSelected ? AppColors.primaryBrand : AppColors.dark,
      ),
      backgroundColor: AppColors.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primaryBrand : AppColors.border,
        ),
      ),
    );
  }
}
