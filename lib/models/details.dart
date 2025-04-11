import 'package:navigation/models/movie.dart';

class Details extends Movie {
  final String description;
  final String? descriptionSource;
  final int? runtime;
  final String imagePath;
  final dynamic rating;
  final int ratingCount;
  final List<String> genres;
  final List<String> pictures;
  final List<Episode> episodes;

  Details({
    required super.id,
    required super.name,
    required super.permalink,
    required super.startDate,
    super.endDate,
    required super.country,
    required super.network,
    required super.status,
    required super.imageThumbnailPath,
    required this.description,
    this.descriptionSource,
    this.runtime,
    required this.imagePath,
    required this.rating,
    required this.ratingCount,
    required this.genres,
    required this.pictures,
    required this.episodes,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'],
      name: json['name'],
      permalink: json['permalink'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      country: json['country'],
      network: json['network'],
      status: json['status'],
      imageThumbnailPath: json['image_thumbnail_path'],
      description: json['description'],
      descriptionSource: json['description_source'],
      runtime: json['runtime'],
      imagePath: json['image_path'],
      rating: json['rating'],
      ratingCount: json['rating_count'],
      genres: List<String>.from(json['genres']),
      pictures: List<String>.from(json['pictures']),
      episodes: List<Episode>.from(
        json['episodes'].map((e) => Episode.fromJson(e)),
      ),
    );
  }
}

class Episode {
  final int season;
  final int episode;
  final String name;
  final DateTime airDate;

  Episode({
    required this.season,
    required this.episode,
    required this.name,
    required this.airDate,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      season: json['season'],
      episode: json['episode'],
      name: json['name'],
      airDate: DateTime.parse(json['air_date']),
    );
  }
}
