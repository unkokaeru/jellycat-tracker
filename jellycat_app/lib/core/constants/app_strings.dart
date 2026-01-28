/// Application-wide string constants
class AppStrings {
  AppStrings._();

  // App info
  static const String appName = 'Jellycat Tracker';
  static const String appTagline = 'Track Your Plushie Collection';

  // Navigation
  static const String navCatalog = 'Catalog';
  static const String navCollection = 'My Collection';
  static const String navWishlist = 'Wishlist';

  // Catalog
  static const String catalogTitle = 'Jellycat Catalog';
  static const String catalogSearchHint = 'Search Jellycats...';
  static const String catalogFilterByCollection = 'Filter by Collection';
  static const String catalogAllCollections = 'All Collections';

  // Collection
  static const String collectionTitle = 'My Collection';
  static const String collectionEmpty = 'Your collection is empty';
  static const String collectionEmptyHint = 'Start adding Jellycats from the catalog!';
  static const String collectionValue = 'Collection Value';
  static const String collectionCount = 'Items in Collection';

  // Wishlist
  static const String wishlistTitle = 'My Wishlist';
  static const String wishlistEmpty = 'Your wishlist is empty';
  static const String wishlistEmptyHint = 'Add Jellycats you\'d like to own!';
  static const String wishlistValue = 'Wishlist Value';

  // Detail page
  static const String detailAddToCollection = 'Add to Collection';
  static const String detailRemoveFromCollection = 'Remove from Collection';
  static const String detailAddToWishlist = 'Add to Wishlist';
  static const String detailRemoveFromWishlist = 'Remove from Wishlist';
  static const String detailPrice = 'Price';
  static const String detailCollection = 'Collection';
  static const String detailSizes = 'Available Sizes';
  static const String detailColors = 'Available Colors';
  static const String detailStatus = 'Status';
  static const String detailReleaseDate = 'Release Date';
  static const String detailRetiredDate = 'Retired Date';

  // Status badges
  static const String statusNew = 'New';
  static const String statusRetired = 'Retired';
  static const String statusPlanned = 'Planned';
  static const String statusAvailable = 'Available';

  // Actions
  static const String actionSearch = 'Search';
  static const String actionFilter = 'Filter';
  static const String actionSort = 'Sort';
  static const String actionCancel = 'Cancel';
  static const String actionSave = 'Save';
  static const String actionDelete = 'Delete';

  // Error messages
  static const String errorGeneric = 'Something went wrong';
  static const String errorNoInternet = 'No internet connection';
  static const String errorLoadingData = 'Error loading data';
  static const String errorSavingData = 'Error saving data';
}
