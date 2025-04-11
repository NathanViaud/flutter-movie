import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:provider/provider.dart';
import '../viewmodels/episode_viewmodel.dart';
import '../viewmodels/movie_viewmodel.dart';
import 'package:sqflite/sqflite.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _totalWatchedEpisodes = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWatchedEpisodesCount();
    final productViewModel = Provider.of<ProductViewModel>(
      context,
      listen: false,
    );
    if (productViewModel.products.isEmpty) {
      productViewModel.fetchMovies();
    }
  }

  Future<void> _loadWatchedEpisodesCount() async {
    final episodeViewModel = Provider.of<EpisodeViewModel>(
      context,
      listen: false,
    );

    final db = await episodeViewModel.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM watched_episodes',
    );
    final count = Sqflite.firstIntValue(result) ?? 0;

    setState(() {
      _totalWatchedEpisodes = count;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: Text('Profile'))],
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListView(
          children: [
            Card(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Avatar(initials: 'JD'),
                    SizedBox(height: 16),
                    Text('User Profile').h3(),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.user),
                            SizedBox(width: 8),
                            Text(
                              'Episodes Watched: $_totalWatchedEpisodes',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Watching Statistics').h4(),
            SizedBox(height: 8),
            Card(
              child: SizedBox(
                width: double.infinity,
                child:
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Episodes Watched: $_totalWatchedEpisodes',
                            ).p(),
                          ],
                        ),
              ),
            ),
            SizedBox(height: 16),
            Text('Recently Watched Shows').h4(),
            SizedBox(height: 8),
            Consumer<ProductViewModel>(
              builder: (context, productViewModel, _) {
                if (productViewModel.loading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                productViewModel.products.length > 5
                                    ? 5
                                    : productViewModel.products.length,
                            itemBuilder: (context, index) {
                              final movie = productViewModel.products[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      movie.imageThumbnailPath,
                                      height: 100,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      width: 80,
                                      child: Text(
                                        movie.name,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
