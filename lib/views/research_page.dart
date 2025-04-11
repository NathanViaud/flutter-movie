import 'package:navigation/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../viewmodels/movie_viewmodel.dart';
import 'detail_page.dart';

class ResearchPage extends StatefulWidget {
  @override
  ResearchPageState createState() => ResearchPageState();
}

class ResearchPageState extends State<ResearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie>? _searchResults;
  bool _isSearching = false;

  void _performSearch(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      final viewModel = Provider.of<ProductViewModel>(context, listen: false);
      _searchResults = await viewModel.searchMovies(query);
      setState(() {
        _isSearching = false;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _performSearch,
          placeholder: const Text('Search something...'),
          leading: StatedWidget.builder(
            builder: (context, states) {
              if (states.hovered) {
                return const Icon(Icons.search);
              } else {
                return const Icon(Icons.search).iconMutedForeground();
              }
            },
          )
        ),
      ),
      ],
      child: Column(
        children: [
          Expanded(
            child: _isSearching
                ? Center(child: CircularProgressIndicator())
                : _searchResults == null || _searchResults!.isEmpty
                    ? Center(child: Text('No results found'))
                    : ListView.builder(
                        itemCount: _searchResults?.length ?? 0,
                        itemBuilder: (context, index) {
                          final movie = _searchResults![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0), // Ajustez la valeur selon vos besoins
                            child: CardButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(id: movie.id),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                      movie.imageThumbnailPath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Espace entre l'image et le texte
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(movie.name),
                                        Text(movie.startDate).muted(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
          ),
          const SizedBox(height: 8), // Espace entre les cartes
        ],
      ),
    );
  }
}