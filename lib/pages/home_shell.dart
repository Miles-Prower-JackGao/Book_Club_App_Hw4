import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeShell extends StatelessWidget {
  final Widget child;
  const HomeShell({super.key, required this.child});

  static const _routeNames = ['byAuthor', 'byTitle', 'profile'];

  int _currentIndex(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/byTitle')) return 1;
    if (path.startsWith('/profile')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: Text(index == 2 ? 'Profile' : 'Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => context.goNamed('profile'),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.goNamed(_routeNames[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'By Author',
          ),
          NavigationDestination(
            icon: Icon(Icons.text_fields),
            label: 'By Title',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}