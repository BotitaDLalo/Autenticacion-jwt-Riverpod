import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_app_latest/config/router/app_router_notifier.dart';
import 'package:teslo_app_latest/features/auth/auth.dart';
import 'package:teslo_app_latest/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_app_latest/features/products/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],

    redirect: (context, state) {
      print(state.matchedLocation);
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },

    ///! TODO: Bloquear si no se está autenticado de alguna manera
  );
}); 

// final appRouter = GoRouter(
//   initialLocation: '/splash',
//   routes: [
//     GoRoute(
//       path: '/splash',
//       builder: (context, state) => const CheckAuthStatusScreen(),
//     ),

//     ///* Auth Routes
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => const LoginScreen(),
//     ),
//     GoRoute(
//       path: '/register',
//       builder: (context, state) => const RegisterScreen(),
//     ),

//     ///* Product Routes
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const ProductsScreen(),
//     ),
//   ],

//   ///! TODO: Bloquear si no se está autenticado de alguna manera
// );
