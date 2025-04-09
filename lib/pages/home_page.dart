import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../services/api.dart';
import '../models/movie.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: FutureBuilder<List<Movie>>(
        future: _apiService.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No popular shows found'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 32.0,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Movie movie = snapshot.data![index];
                return CardImage(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(id: movie.id),
                      ),
                    );
                  },
                  image: SizedBox(
                    width: double.infinity,
                    child: Image.network(movie.imageThumbnailPath),
                  ),
                  title: Text(movie.name).h3(),
                  subtitle: Text(movie.startDate).muted(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
