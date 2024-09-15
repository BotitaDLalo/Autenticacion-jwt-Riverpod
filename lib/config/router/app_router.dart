import 'package:go_router/go_router.dart';
import 'package:teslo_app_latest/features/auth/auth.dart';
import 'package:teslo_app_latest/features/products/presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [

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
  ///! TODO: Bloquear si no se está autenticado de alguna manera
);