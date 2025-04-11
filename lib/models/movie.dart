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

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['name'],
      permalink: map['permalink'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      country: map['country'],
      network: map['network'],
      status: map['status'],
      imageThumbnailPath: map['imageThumbnailPath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'permalink': permalink,
      'startDate': startDate,
      'endDate': endDate,
      'country': country,
      'network': network,
      'status': status,
      'imageThumbnailPath': imageThumbnailPath,
    };
  }
}
