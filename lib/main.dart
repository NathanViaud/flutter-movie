import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'bottom/bottom_home.dart';

void main() {
  runApp(const MyApp());
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
