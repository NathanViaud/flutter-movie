import 'package:shadcn_flutter/shadcn_flutter.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  void open(BuildContext context, int count) {
    openDrawer(
      context: context,
      expands: true,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(48),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Drawer is here'),
                const Gap(16),
                SecondaryButton(
                  onPressed: () {
                    closeOverlay(context);
                  },
                  child: const Text('Close Drawer'),
                ),
              ],
            ),
          ),
        );
      },
      position: OverlayPosition.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: PrimaryButton(
          onPressed: () {
            open(context, 0);
          },
          child: const Text('Open Drawer'),
        ),
      ),
    );
  }
}
