import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  Future<List<dynamic>> fetchPopular() async {
    final response = await http.get(
      Uri.parse('https://www.episodate.com/api/most-popular?page=1'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['tv_shows'];
    } else {
      throw Exception('Failed to load popular shows');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: FutureBuilder<List<dynamic>>(
        future: fetchPopular(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the data, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, display the error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data, display a message
            return Center(child: Text('No popular shows found'));
          } else {
            // If data is available, display the list of popular shows
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns
                crossAxisSpacing: 4.0, // Spacing between columns
                mainAxisSpacing: 32.0, // Spacing between rows
                childAspectRatio:
                    1.0, // Aspect ratio of each item (width / height)
              ),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var show = snapshot.data![index];
                return CardImage(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(id: show['id']),
                      ),
                    );
                  },
                  image: SizedBox(
                    width: double.infinity,
                    child: Image.network(show['image_thumbnail_path']),
                  ),
                  title: Text(show['name']).h3(),
                  subtitle: Text(show['start_date']).muted(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
