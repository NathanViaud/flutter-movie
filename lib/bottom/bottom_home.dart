import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../views/home_page.dart';
import '../views/research_page.dart';
import '../views/profile_page.dart';

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
  final List<Widget> pages = [HomePage(), ResearchPage(), ProfilePage()];

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
            buildButton('Home', LucideIcons.house),
            buildButton('Research', LucideIcons.search),
            buildButton('Profile', LucideIcons.user),
          ],
        ),
      ],
      child: pages[selected],
    );
  }
}
