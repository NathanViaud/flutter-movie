class Movie {
  final int id;
  final String name;
  final String permalink;
  final String startDate;
  final String? endDate;
  final String country;
  final String network;
  final String status;
  final String imageThumbnailPath;

  Movie({
    required this.id,
    required this.name,
    required this.permalink,
    required this.startDate,
    this.endDate,
    required this.country,
    required this.network,
    required this.status,
    required this.imageThumbnailPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      permalink: json['permalink'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      country: json['country'],
      network: json['network'],
      status: json['status'],
      imageThumbnailPath: json['image_thumbnail_path'],
    );
  }
}
