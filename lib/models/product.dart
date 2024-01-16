import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String imageUrl;
  final String category;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        stock,
      ];

  factory Product.fromJson(Map<String, dynamic> json, {String? id}) {
    return Product(
      id: id ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl:
          json['imageUrl'] ?? 'https://source.unsplash.com/random/?fashion',
      category: json['category'] ?? '',
      stock: json['stock'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'stock': stock,
    };
  }
}
