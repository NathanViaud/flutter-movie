import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/details.dart';

class EpisodeViewModel extends ChangeNotifier {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'watched_episodes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
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

  Future<void> toggleWatchedStatus(int showId, int season, int episode) async {
    final db = await database;
    final isWatched = await isEpisodeWatched(showId, season, episode);
    
    if (isWatched) {
      await db.delete(
        'watched_episodes',
        where: 'show_id = ? AND season = ? AND episode = ?',
        whereArgs: [showId, season, episode],
      );
    } else {
      await db.insert(
        'watched_episodes',
        {
          'show_id': showId,
          'season': season,
          'episode': episode,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    notifyListeners();
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