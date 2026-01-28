import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/jellycat_entity.dart';
import '../../../collection/presentation/providers/collection_providers.dart';
import '../../../wishlist/presentation/providers/wishlist_providers.dart';

/// Detail page for a single Jellycat
class JellycatDetailPage extends ConsumerWidget {
  final JellycatEntity jellycat;

  const JellycatDetailPage({super.key, required this.jellycat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInCollectionAsync = ref.watch(isInCollectionProvider(jellycat.id));
    final isInWishlistAsync = ref.watch(isInWishlistProvider(jellycat.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(jellycat.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              width: double.infinity,
              height: 300,
              color: AppColors.accentCream,
              child: Icon(
                Icons.pets,
                size: 120,
                color: AppColors.primaryBrand.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and collection
                  Text(
                    jellycat.name,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    jellycat.collectionName,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.secondaryBrand,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Price and status
                  Row(
                    children: [
                      Text(
                        jellycat.formattedPrice,
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.primaryBrand,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      _buildStatusChip(jellycat),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Description
                  if (jellycat.description != null) ...[
                    Text(
                      'Description',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      jellycat.description!,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Available sizes
                  if (jellycat.sizes.isNotEmpty) ...[
                    Text(
                      AppStrings.detailSizes,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: jellycat.sizes.map((size) {
                        return Chip(
                          label: Text(size),
                          backgroundColor: AppColors.accentCream,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Available colors
                  if (jellycat.colors.isNotEmpty) ...[
                    Text(
                      AppStrings.detailColors,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: jellycat.colors.map((color) {
                        return Chip(
                          label: Text(color),
                          backgroundColor: AppColors.accentPink.withOpacity(0.3),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Dates
                  Text(
                    AppStrings.detailReleaseDate,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMMM d, y').format(jellycat.releasedDate),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  if (jellycat.retiredDate != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.detailRetiredDate,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMMM d, y').format(jellycat.retiredDate!),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 32),
                  
                  // Action buttons
                  isInCollectionAsync.when(
                    data: (isInCollection) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (isInCollection) {
                                  ref
                                      .read(collectionNotifierProvider.notifier)
                                      .removeFromCollection(jellycat.id);
                                } else {
                                  ref
                                      .read(collectionNotifierProvider.notifier)
                                      .addToCollection(jellycat.id);
                                }
                              },
                              icon: Icon(isInCollection
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline),
                              label: Text(
                                isInCollection
                                    ? AppStrings.detailRemoveFromCollection
                                    : AppStrings.detailAddToCollection,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          isInWishlistAsync.when(
                            data: (isInWishlist) {
                              return SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    if (isInWishlist) {
                                      ref
                                          .read(wishlistNotifierProvider.notifier)
                                          .removeFromWishlist(jellycat.id);
                                    } else {
                                      ref
                                          .read(wishlistNotifierProvider.notifier)
                                          .addToWishlist(jellycat.id);
                                    }
                                  },
                                  icon: Icon(isInWishlist
                                      ? Icons.favorite
                                      : Icons.favorite_outline),
                                  label: Text(
                                    isInWishlist
                                        ? AppStrings.detailRemoveFromWishlist
                                        : AppStrings.detailAddToWishlist,
                                  ),
                                ),
                              );
                            },
                            loading: () => const CircularProgressIndicator(),
                            error: (_, __) => const SizedBox.shrink(),
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(JellycatEntity jellycat) {
    Color chipColor;
    if (jellycat.isRetired) {
      chipColor = AppColors.error;
    } else if (jellycat.isNew) {
      chipColor = AppColors.info;
    } else if (jellycat.isPlanned) {
      chipColor = AppColors.warning;
    } else {
      chipColor = AppColors.success;
    }

    return Chip(
      label: Text(
        jellycat.statusLabel,
        style: AppTextStyles.labelMedium.copyWith(
          color: chipColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor.withOpacity(0.2),
    );
  }
}
