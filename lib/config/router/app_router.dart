import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/features/home/presentation/screen/book_list_screen.dart';
import 'package:bazargan/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// final List<String> publicRoutes = [
//   RoutePaths.login,
//   RoutePaths.otp,
//   RoutePaths.getName,
// ];

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutePaths.home,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RoutePaths.bookList,
      builder: (context, state) => const BookListScreen(),
    ),
  ],

  //! Redirect
  // redirect: (context, state) {
  //   final isLoggedIn = SessionManager.instance.isLoggedIn();
  //   final currentPath =
  //       state.matchedLocation; //! fucking important -> MatchedLocation

  //   final isPublicRoute = publicRoutes.contains(currentPath);

  //   if (!isLoggedIn && !isPublicRoute) return '/login';
  //   if (isLoggedIn && currentPath == '/login') return '/';
  //   return null;
  // },

  //! Not found
  // errorBuilder: (context, state) => const NotFoundScreen(),
);
