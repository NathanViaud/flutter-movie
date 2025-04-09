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
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.7, // Adjust this value based on your image ratio
                        ),
                        itemCount: _searchResults?.length ?? 0,
                        itemBuilder: (context, index) {
                          final movie = _searchResults![index];
                          return CardImage(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(id: movie.id),
                                ),
                              );
                            },
                            image: SizedBox.expand(
                              child: Image.network(
                                movie.imageThumbnailPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(movie.name).h4(),
                            subtitle: Text(movie.startDate).muted(),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}