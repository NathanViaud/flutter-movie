import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatelessWidget {
  final int id;

  Future<dynamic> fetchDetails() async {
    final response = await http.get(
      Uri.parse('https://www.episodate.com/api/show-details?q=$id'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['tvShow'];
    } else {
      throw Exception('Failed to load details');
    }
  }

  const DetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<dynamic>(
          future: fetchDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final details = snapshot.data;
              return ListView(
                children: [
                  Text('${details['name']}').h1(),
                  Image.network(details['image_path']),
                  Text('${details['description']}').p(),
                  Text('Start Date: ${details['start_date']}').muted(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
