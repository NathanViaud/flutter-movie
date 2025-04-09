import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../pages/home_page.dart';
import '../pages/explore_page.dart';
import '../pages/library_page.dart';
import '../pages/drawer_page.dart';

NavigationBarAlignment alignment = NavigationBarAlignment.spaceAround;
bool expands = true;
NavigationLabelType labelType = NavigationLabelType.none;
bool customButtonStyle = true;
bool expanded = true;

int selected = 0;

NavigationItem buildButton(String label, IconData icon) {
  return NavigationItem(
    style:
        customButtonStyle
            ? const ButtonStyle.muted(density: ButtonDensity.icon)
            : null,
    selectedStyle:
        customButtonStyle
            ? const ButtonStyle.fixed(density: ButtonDensity.icon)
            : null,
    label: Text(label),
    child: Icon(icon),
  );
}

class BottomHome extends StatefulWidget {
  @override
  _BottomHomeState createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  final List<Widget> pages = [
    HomePage(),
    ExplorePage(),
    LibraryPage(),
    DrawerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      footers: [
        NavigationBar(
          alignment: alignment,
          labelType: labelType,
          expanded: expanded,
          expands: expands,
          onSelected: (index) {
            setState(() {
              selected = index;
            });
          },
          index: selected,
          children: [
            buildButton('Home', BootstrapIcons.house),
            buildButton('Explore', BootstrapIcons.compass),
            buildButton('Library', BootstrapIcons.musicNoteList),
            buildButton('Profile', BootstrapIcons.person),
          ],
        ),
      ],
      child: pages[selected],
    );
  }
}
