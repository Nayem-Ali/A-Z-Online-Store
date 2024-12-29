import 'package:cloud_firestore/cloud_firestore.dart';

class Carts {
  String? documentID;
  final String brand;
  final String category;
  final String description;
  final double discountPercentage;
  final int id;
  final List images;
  final int price;
  final double rating;
  final int stock;
  final String thumbnail;
  final String title;

  Carts({
    this.documentID,
    required this.brand,
    required this.category,
    required this.description,
    required this.discountPercentage,
    required this.id,
    required this.images,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.title,
  });

  factory Carts.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Carts(
      documentID: snapshot.id,
      brand: data["brand"],
      category: data["category"],
      description: data["description"],
      discountPercentage: data["discountPercentage"],
      id: data["id"],
      images: data["images"],
      price: data["price"],
      rating: data["rating"],
      stock: data["stock"],
      thumbnail: data["thumbnail"],
      title: data["title"],
    );
  }

  toJson() {
    return {
      "brand": brand,
      "category": category,
      'description': description,
      "discountPercentage": discountPercentage,
      "id": id,
      "images": images,
      "price": price,
      "rating": rating,
      "stock": stock,
      "thumbnail": thumbnail,
      "title": title,
    };
  }
}


