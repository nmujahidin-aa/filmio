class RentalModel {
  final int movieId;
  final String title;
  final int days;
  final int totalPrice;
  final DateTime createdAt;

  RentalModel({
    required this.movieId,
    required this.title,
    required this.days,
    required this.totalPrice,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "movieId": movieId,
      "title": title,
      "days": days,
      "totalPrice": totalPrice,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    return RentalModel(
      movieId: json['movieId'],
      title: json['title'],
      days: json['days'],
      totalPrice: json['totalPrice'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
