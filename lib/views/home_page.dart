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
      child:
          viewModel.loading
              ? Center(child: CircularProgressIndicator())
              : viewModel.products.isEmpty
              ? Center(child: Text('No popular shows found'))
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 32.0,
                  childAspectRatio: 1.0,
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
                    image: SizedBox(
                      width: double.infinity,
                      child: Image.network(movie.imageThumbnailPath),
                    ),
                    title: Text(movie.name).h3(),
                    subtitle: Text(movie.startDate).muted(),
                  );
                },
              ),
    );
  }
}
