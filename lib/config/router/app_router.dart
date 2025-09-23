import 'package:bazargan/config/router/main_screen.dart';
import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/features/home/presentation/screen/book_list_screen.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/screen/my_library_bookmarks_screen.dart';
import 'package:bazargan/features/profile_comments/presentation/screen/profile_comments_screen.dart';
import 'package:bazargan/features/profile_transaction/presentation/screen/profile_transaction_screen.dart';
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
    //! Main
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const MainScreen(),
    ),

    GoRoute(
      path: RoutePaths.bookList,
      builder: (context, state) => const BookListScreen(),
    ),

    GoRoute(
      path: RoutePaths.myLibraryBookmarks,
      builder: (context, state) => const MyLibraryBookmarksScreen(),
    ),

    GoRoute(
      path: RoutePaths.profileComments,
      builder: (context, state) => const ProfileCommentsScreen(),
    ),
    GoRoute(
      path: RoutePaths.profileTransaction,
      builder: (context, state) => const ProfileTransactionScreen(),
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
