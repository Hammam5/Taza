class Ad {
  final String imageUrl;
  final String productName;
  final String brandName;
  final String price;
  final String discount;
  final String expDate;
  final int totalBuyers;
  final int productID;

  Ad({
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.discount,
    required this.expDate,
    required this.price,
    required this.totalBuyers,
    required this.productID,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      imageUrl: json['product_image'] ?? '',
      productName: json['name'] ?? '',
      brandName: json['brand_name'] ?? '',
      price: json['price'] ?? '',
      discount: json['discount_percentage']?.toString() ?? '',
      expDate: json['expiry_date'] ?? '',
      totalBuyers: json['user_count'] ?? 0,
      productID: json['product_id'] ?? 0,
    );
  }

  static List<Ad> parseAdList(List<dynamic> list) {
    return list.map((json) => Ad.fromJson(json)).toList();
  }
}
