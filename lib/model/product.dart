class Product {
  final String photoUrl;
  final String name;
  final double price;
  final String createdAt;
  final String description;
  final int id;
  final String category;
  final String updatedAt;

  Product({
    required this.photoUrl,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.description,
    required this.id,
    required this.category,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      photoUrl: json['photo_url'] ,
      name: json['name'] ,
      price: json['price'] ,
      createdAt: json['created_at'],
      description: json['description'] ,
      id: json['id'] ,
      category: json['category'] ,
      updatedAt: json['updated_at'] ,
    );
  }
}
class ProductsResponse {
  final bool success;
  final String message;
  final Product products;

  ProductsResponse({
    required this.success,
    required this.message,
    required this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      success: json['success'],
      message: json['message'],
      products: Product.fromJson(json['product']),
    );
  }
}