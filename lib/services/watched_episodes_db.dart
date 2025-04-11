import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WatchedEpisodesDB {
  static final WatchedEpisodesDB _instance = WatchedEpisodesDB._internal();
  static Database? _database;

  factory WatchedEpisodesDB() {
    return _instance;
  }

  WatchedEpisodesDB._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'watched_episodes.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE watched_episodes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        show_id INTEGER,
        season INTEGER,
        episode INTEGER,
        UNIQUE(show_id, season, episode)
      )
    ''');
  }

  Future<void> markEpisodeAsWatched(int showId, int season, int episode) async {
    final db = await database;
    await db.insert('watched_episodes', {
      'show_id': showId,
      'season': season,
      'episode': episode,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> markEpisodeAsUnwatched(
    int showId,
    int season,
    int episode,
  ) async {
    final db = await database;
    await db.delete(
      'watched_episodes',
      where: 'show_id = ? AND season = ? AND episode = ?',
      whereArgs: [showId, season, episode],
    );
  }

  Future<bool> isEpisodeWatched(int showId, int season, int episode) async {
    final db = await database;
    final result = await db.query(
      'watched_episodes',
      where: 'show_id = ? AND season = ? AND episode = ?',
      whereArgs: [showId, season, episode],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getWatchedEpisodes(int showId) async {
    final db = await database;
    return await db.query(
      'watched_episodes',
      where: 'show_id = ?',
      whereArgs: [showId],
    );
  }
}
