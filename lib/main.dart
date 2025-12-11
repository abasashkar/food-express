import 'package:ecomerce_bloc_new/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/cart/bloc/cart_bloc.dart';
import 'package:ecomerce_bloc_new/logic/bloc/wishlist/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Wrap the app with BlocProviders once
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocBloc>(create: (_) => AuthBlocBloc()),
        BlocProvider<WishlistBloc>(create: (_) => WishlistBloc()),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
