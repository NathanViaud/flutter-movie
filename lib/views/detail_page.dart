import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';
import '../models/details.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: FutureBuilder<Details>(
        future: ApiService().fetchDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found'));
          } else {
            final details = snapshot.data!;
            return Scaffold(
              headers: [
                AppBar(
                  title: Text(details.name),
                  leading: [
                    OutlineButton(
                      density: ButtonDensity.icon,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Image.network(details.imagePath),
                    Text(details.description).p(),
                    Text('Start Date: ${details.startDate}').muted(),
                    Text(
                      'Rating: ${details.rating} (${details.ratingCount} votes)',
                    ).muted(),
                    Text('Runtime: ${details.runtime} minutes').muted(),
                    Text('Genres: ${details.genres.join(', ')}').muted(),
                    SizedBox(height: 16),
                    Text('Episodes').h3(),
                    ...details.episodes.map(
                      (episode) => Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${episode.season}x${episode.episode} - ${episode.name}',
                            ),
                            Text(
                              'Aired: ${episode.airDate.toString().split(' ')[0]}',
                            ).muted(),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
