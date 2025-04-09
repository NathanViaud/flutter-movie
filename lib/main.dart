import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'bottom/bottom_home.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorSchemes.darkZinc(), radius: 0.75),
      home: BottomHome(),
    );
  }
}
