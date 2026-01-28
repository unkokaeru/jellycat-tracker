import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../providers/wishlist_providers.dart';
import '../../catalog/presentation/widgets/jellycat_card.dart';

/// Page displaying user's wishlist
class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistJellycatsAsync = ref.watch(wishlistJellycatsProvider);
    final wishlistValueAsync = ref.watch(wishlistValueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wishlistTitle),
      ),
      body: Column(
        children: [
          // Wishlist stats
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                wishlistJellycatsAsync.when(
                  data: (jellycats) {
                    return Column(
                      children: [
                        Text(
                          '${jellycats.length}',
                          style: AppTextStyles.displayMedium.copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Items in Wishlist',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const LoadingIndicator(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),
                wishlistValueAsync.when(
                  data: (value) {
                    return Column(
                      children: [
                        Text(
                          '£${value.toStringAsFixed(2)}',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.wishlistValue,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const LoadingIndicator(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          
          // Wishlist grid
          Expanded(
            child: wishlistJellycatsAsync.when(
              data: (jellycats) {
                if (jellycats.isEmpty) {
                  return EmptyStateWidget(
                    title: AppStrings.wishlistEmpty,
                    message: AppStrings.wishlistEmptyHint,
                    icon: Icons.favorite_outline,
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: jellycats.length,
                  itemBuilder: (context, index) {
                    return JellycatCard(jellycat: jellycats[index]);
                  },
                );
              },
              loading: () => const LoadingIndicator(),
              error: (error, stack) => ErrorDisplayWidget(
                message: AppStrings.errorLoadingData,
                onRetry: () {
                  ref.invalidate(wishlistJellycatsProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
