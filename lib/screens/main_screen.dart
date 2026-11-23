import "package:android_dev/screens/tabs/activity_tab.dart";
import "package:android_dev/screens/tabs/home_tab.dart";
import "package:android_dev/screens/tabs/new_post_tab.dart";
import "package:android_dev/screens/tabs/placeholder_tab.dart";
import "package:android_dev/screens/tabs/profile_tab.dart";
import "package:android_dev/widgets/animated_indexed_stack.dart";
import "package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart";
import "package:flutter/material.dart";

class MainScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _icons = [
    Icons.home,
    Icons.search,
    Icons.add_box,
    Icons.favorite_border,
    Icons.person_outline,
  ];

  // Not const any more: the New post tab needs a callback that switches
  // back to the feed after publishing.
  late final List<Widget> _pages = [
    const HomeTab(),
    const PlaceholderTab(title: 'Search', icon: Icons.search),
    NewPostTab(onPosted: () => setState(() => _currentIndex = 0)),
    const ActivityTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        backgroundColor: Colors.white,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: AnimatedIndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
