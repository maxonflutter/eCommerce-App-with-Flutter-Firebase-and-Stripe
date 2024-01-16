import 'package:db_client/db_client.dart';

import '../models/product.dart';

class ProductRepository {
  final DbClient dbClient;

  const ProductRepository({required this.dbClient});

  Stream<List<Product>> streamProducts(String category) {
    final productsStream = dbClient.streamAllBy(
      collection: 'products',
      field: 'category',
      value: category,
    );

    return productsStream.map((productsData) {
      return productsData
          .map((productData) =>
              Product.fromJson(productData.data, id: productData.id))
          .toList();
    });
  }

  Future<void> createProducts() async {
    try {
      for (var product in products) {
        await dbClient.add(collection: 'products', data: product);
      }
    } catch (err) {}
  }
}

const products = [
  {
    "name": "Performance Running T-Shirt",
    "description":
        "Breathable and quick-drying T-shirt, ideal for long-distance running. Available in multiple colors.",
    "price": 29.99,
    "imageUrl": "https://source.unsplash.com/random/?sport,clothes",
    "category": "Sportswear",
    "stock": 200
  },
  {
    "name": "Men's Basketball Shorts",
    "description":
        "Comfortable and lightweight basketball shorts, designed for optimal movement and durability.",
    "price": 34.99,
    "imageUrl": "https://source.unsplash.com/random/?sport,clothes",
    "category": "Sportswear",
    "stock": 150
  },
  {
    "name": "Cycling Jersey",
    "description":
        "High-performance cycling jersey with moisture-wicking fabric and rear pockets for essentials.",
    "price": 45.99,
    "imageUrl": "https://source.unsplash.com/random/?sport,clothes",
    "category": "Cycling",
    "stock": 100
  },
  {
    "name": "Trail Running Shoes",
    "description":
        "Durable and supportive trail running shoes with enhanced grip for rough terrain.",
    "price": 89.99,
    "imageUrl": "https://source.unsplash.com/random/?sport,clothes",
    "category": "Footwear",
    "stock": 80
  },
  {
    "name": "Fitness Training Tracksuit",
    "description":
        "Comfortable tracksuit for fitness training, made with flexible and sweat-wicking material.",
    "price": 59.99,
    "imageUrl": "https://source.unsplash.com/random/?sport,clothes",
    "category": "Sportswear",
    "stock": 120
  }
];
