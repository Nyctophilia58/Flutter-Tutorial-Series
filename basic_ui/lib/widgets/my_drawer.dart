import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../themes/theme_provider.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.colorScheme.background,
      child: Column(
        children: [
          Theme(
            data: theme.copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(child:
            DrawerHeader(
              child: Icon(
                Icons.note,
                size: 100,
                color: theme.colorScheme.inversePrimary,
              ),
            ),
            ),
          ),
          Divider(
            color: theme.colorScheme.secondary,
            thickness: 2,
            indent: 20.0,
            endIndent: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.brightness_6),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
              title: Text('Brightness')
            ),
          ),
        ],
      ),
    );
  }
}