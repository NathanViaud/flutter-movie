import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<ProductViewModel>(context, listen: false);
    viewModel.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      headers: [AppBar(title: const Text('Popular shows'))],
      child: Column(
        children: [
          Expanded(
            child:
                viewModel.loading
                    ? Center(child: CircularProgressIndicator())
                    : viewModel.products.isEmpty
                    ? Center(child: Text('No popular shows found'))
                    : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio:
                            0.7, // Adjust this value based on your image ratio
                      ),
                      itemCount: viewModel.products.length,
                      itemBuilder: (context, index) {
                        final movie = viewModel.products[index];
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
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Pagination(
              page: viewModel.page,
              totalPages: viewModel.totalPages,
              onPageChanged: (value) {
                viewModel.page = value;
                viewModel.fetchMovies();
              },
              maxPages: 1,
              showLabel: false,
              showSkipToLastPage: false,
            ),
          ),
        ],
      ),
    );
  }
}
