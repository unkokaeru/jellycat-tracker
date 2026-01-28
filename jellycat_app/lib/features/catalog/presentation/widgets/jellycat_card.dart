import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/jellycat_entity.dart';
import 'jellycat_detail_page.dart';

/// Card widget displaying a Jellycat item
class JellycatCard extends ConsumerWidget {
  final JellycatEntity jellycat;

  const JellycatCard({super.key, required this.jellycat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JellycatDetailPage(jellycat: jellycat),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: AppColors.accentCream,
                child: Icon(
                  Icons.pets,
                  size: 64,
                  color: AppColors.primaryBrand.withOpacity(0.3),
                ),
              ),
            ),
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      jellycat.name,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.dark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Collection
                    Text(
                      jellycat.collectionName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Price and status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          jellycat.formattedPrice,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.primaryBrand,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildStatusBadge(jellycat),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(JellycatEntity jellycat) {
    Color badgeColor;
    if (jellycat.isRetired) {
      badgeColor = AppColors.error;
    } else if (jellycat.isNew) {
      badgeColor = AppColors.info;
    } else if (jellycat.isPlanned) {
      badgeColor = AppColors.warning;
    } else {
      badgeColor = AppColors.success;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        jellycat.statusLabel,
        style: AppTextStyles.labelSmall.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
