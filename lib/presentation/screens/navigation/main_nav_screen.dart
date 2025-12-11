import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavScreen extends StatefulWidget {
  final Widget child;

  const MainNavScreen({super.key, required this.child});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int currentIndex = 0;

  final tabs = ['/home', '/shop', '/wishlist', '/account'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: currentIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey.shade500,
            selectedFontSize: 12,
            unselectedFontSize: 11,

            onTap: (index) {
              setState(() => currentIndex = index);
              context.go(tabs[index]);
            },

            items: [
              navItem(Icons.home_outlined, Icons.home, "Home", 0),
              navItem(
                Icons.shopping_bag_outlined,
                Icons.shopping_bag,
                "Shoping",
                1,
              ),
              navItem(Icons.favorite_border, Icons.favorite, "Wishlist", 2),
              navItem(Icons.person_outline, Icons.person, "Account", 3),
            ],
          ),
        ),
      ),
    );
  }

  /// Custom Navigation Item with smooth animation
  BottomNavigationBarItem navItem(
    IconData icon,
    IconData filledIcon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: currentIndex == index
            ? Icon(filledIcon, key: ValueKey(filledIcon))
            : Icon(icon, key: ValueKey(icon)),
      ),
      label: label,
    );
  }
}
