class MovieModel {
  final String name;
  final String? posterUrl;
  final String? description;
  final String rating;

  MovieModel({
    required this.name,
    this.posterUrl,
    this.description,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      name: json['title'] ?? 'No Title',
      posterUrl: json['urlToImage'],
      description: json['description'] ?? 'No description available',
      rating: json['author'] ?? 'Unknown Author',
    );
  }
}