import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
  });

  factory Category.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return Category(
      id: id ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl:
          json['imageUrl'] ?? 'https://source.unsplash.com/random/?fashion',
    );
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl];

  // static const categories = [
  //   Category(
  //       id: '1',
  //       name: 'Sportswear',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '2',
  //       name: 'Cycling',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '3',
  //       name: 'Footwear',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '4',
  //       name: 'Accessories',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '5',
  //       name: 'Watersports',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '6',
  //       name: 'Camping',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '7',
  //       name: 'Indoor',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  //   Category(
  //       id: '8',
  //       name: 'Golf',
  //       imageUrl: 'https://source.unsplash.com/random/?fashion'),
  // ];
}
