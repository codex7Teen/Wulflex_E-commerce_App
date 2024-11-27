class ProductModel {
  final String? id;
  final String brandName;
  final String name;
  final String description;
  final String category;
  final List<String> imageUrls;
  final List<String> weights;
  final List<String> sizes;
  final double retailPrice;
  final double offerPrice;
  final bool isOnSale;
  final bool isFavorite;

  ProductModel(
      {required this.id,
      required this.brandName,
      required this.name,
      required this.description,
      required this.category,
      required this.imageUrls,
      required this.weights,
      required this.sizes,
      required this.retailPrice,
      required this.offerPrice,
      required this.isOnSale,
      this.isFavorite = false});

  factory ProductModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return ProductModel(
      id: documentId ?? map['id'] ?? '',
      brandName: map['brandName'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      weights: List<String>.from(map['weights'] ?? []),
      sizes: List<String>.from(map['sizes'] ?? []),
      retailPrice: (map['retailPrice'] as num?)?.toDouble() ?? 0.0,
      offerPrice: (map['offerPrice'] as num?)?.toDouble() ?? 0.0,
      isOnSale: map['isOnSale'] ?? false,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  // Method to convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brandName': brandName,
      'name': name,
      'description': description,
      'category': category,
      'imageUrls': imageUrls,
      'weights': weights,
      'sizes': sizes,
      'retailPrice': retailPrice,
      'offerPrice': offerPrice,
      'isOnSale': isOnSale,
      'isFavorite': isFavorite,
    };
  }

  // Add a method to copy the model with updated favorite status
  ProductModel copyWith({bool? isFavorite}) {
    return ProductModel(
      id: id,
      brandName: brandName,
      name: name,
      description: description,
      category: category,
      imageUrls: imageUrls,
      weights: weights,
      sizes: sizes,
      retailPrice: retailPrice,
      offerPrice: offerPrice,
      isOnSale: isOnSale,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  bool checkIsFavorite(List<ProductModel> favorites) {
    return favorites.any((favorite) => favorite.id == id);
  }
}
