import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../providers/catalog_providers.dart';
import '../widgets/jellycat_card.dart';
import '../widgets/collection_filter_chip.dart';

/// Catalog page showing all Jellycats with filtering
class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jellycatsAsync = ref.watch(filteredJellycatsProvider);
    final collectionsAsync = ref.watch(allCollectionsProvider);
    final selectedCollection = ref.watch(selectedCollectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.catalogTitle),
      ),
      body: Column(
        children: [
          // Collection filter chips
          SizedBox(
            height: 60,
            child: collectionsAsync.when(
              data: (collections) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    CollectionFilterChip(
                      label: AppStrings.catalogAllCollections,
                      isSelected: selectedCollection == null,
                      onSelected: () {
                        ref.read(selectedCollectionProvider.notifier).state = null;
                      },
                    ),
                    const SizedBox(width: 8),
                    ...collections.map((collection) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CollectionFilterChip(
                          label: collection,
                          isSelected: selectedCollection == collection,
                          onSelected: () {
                            ref.read(selectedCollectionProvider.notifier).state =
                                collection;
                          },
                        ),
                      );
                    }),
                  ],
                );
              },
              loading: () => const LoadingIndicator(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
          ),
          // Jellycats grid
          Expanded(
            child: jellycatsAsync.when(
              data: (jellycats) {
                if (jellycats.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No Jellycats Found',
                    message: 'No Jellycats match your filter',
                    icon: Icons.search_off,
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
                  ref.invalidate(filteredJellycatsProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
