import 'package:ecomerce_bloc_new/presentation/screens/Home/home_screen.dart';
import 'package:ecomerce_bloc_new/presentation/screens/auth/signin_screen.dart';
import 'package:ecomerce_bloc_new/presentation/screens/auth/signup_screen.dart'
    show SignupScreen;
import 'package:ecomerce_bloc_new/presentation/screens/navigation/main_nav_screen.dart';
import 'package:ecomerce_bloc_new/presentation/screens/profile/user_profile.dart';
import 'package:ecomerce_bloc_new/presentation/screens/shoping/shoping_screen.dart';
import 'package:ecomerce_bloc_new/presentation/screens/whitslist/whitslist_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',

    routes: [
      GoRoute(path: '/signin', builder: (_, __) => const SigninScreen()),

      GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),

      ShellRoute(
        builder: (context, state, child) {
          return MainNavScreen(child: child);
        },
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/shop', builder: (_, __) => const ShopingScreen()),
          GoRoute(
            path: '/wishlist',
            builder: (_, __) => const WishlistScreen(),
          ),
          GoRoute(path: '/account', builder: (_, __) => const UserProfile()),
        ],
      ),
    ],
  );
}
