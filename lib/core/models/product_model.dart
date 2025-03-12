class Rating {
  final double rate;

  Rating({required this.rate});

  // Convert Rating object to JSON
  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
    };
  }

  // Convert JSON to Rating object
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final Rating rating; // Rating is now an object

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,  // Rating as an object
  });

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating.toJson(),  // Convert rating object to JSON
    };
  }

  // Convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      rating: Rating.fromJson(json['rating']),  // Convert nested rating object
    );
  }
}
