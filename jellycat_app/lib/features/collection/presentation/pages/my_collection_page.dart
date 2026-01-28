import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../providers/collection_providers.dart';
import '../../catalog/presentation/widgets/jellycat_card.dart';

/// Page displaying user's Jellycat collection
class MyCollectionPage extends ConsumerWidget {
  const MyCollectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionJellycatsAsync = ref.watch(userCollectionJellycatsProvider);
    final collectionValueAsync = ref.watch(collectionValueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.collectionTitle),
      ),
      body: Column(
        children: [
          // Collection stats
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryBrand.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryBrand.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                collectionJellycatsAsync.when(
                  data: (jellycats) {
                    return Column(
                      children: [
                        Text(
                          '${jellycats.length}',
                          style: AppTextStyles.displayMedium.copyWith(
                            color: AppColors.primaryBrand,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.collectionCount,
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
                collectionValueAsync.when(
                  data: (value) {
                    return Column(
                      children: [
                        Text(
                          '£${value.toStringAsFixed(2)}',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.collectionValue,
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
          
          // Collection grid
          Expanded(
            child: collectionJellycatsAsync.when(
              data: (jellycats) {
                if (jellycats.isEmpty) {
                  return EmptyStateWidget(
                    title: AppStrings.collectionEmpty,
                    message: AppStrings.collectionEmptyHint,
                    icon: Icons.collections_outlined,
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
                  ref.invalidate(userCollectionJellycatsProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
