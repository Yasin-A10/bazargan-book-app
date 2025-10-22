import 'package:bazargan/config/router/main_screen.dart';
import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/network/session_manager.dart';
import 'package:bazargan/features/auth/presentation/screen/login_screen.dart';
import 'package:bazargan/features/auth/presentation/screen/otp_screen.dart';
import 'package:bazargan/features/auth/presentation/screen/category_screen.dart';
import 'package:bazargan/features/book/presentation/screen/audio_book_screen.dart';
import 'package:bazargan/features/book/presentation/screen/book_screen.dart';
import 'package:bazargan/features/book/presentation/screen/epub_viewer.dart';
import 'package:bazargan/features/book/presentation/screen/pdf_viewer.dart';
import 'package:bazargan/features/cart/presentation/screen/cart_screen.dart';
import 'package:bazargan/features/home/presentation/screen/book_list_screen.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/screen/my_library_bookmarks_screen.dart';
import 'package:bazargan/features/profile_comments/presentation/screen/profile_comments_screen.dart';
import 'package:bazargan/features/profile_favorites/presentation/screen/profile_favorites_screen.dart';
import 'package:bazargan/features/profile_transaction/presentation/screen/profile_transaction_screen.dart';
import 'package:bazargan/features/search/presentation/screen/original_search_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final List<String> publicRoutes = [
  RoutePaths.login,
  RoutePaths.otp,
  RoutePaths.category,
];

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutePaths.home,
  routes: [
    //! Auth
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.otp,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return OtpScreen(
          phoneNumber: extra['phoneNumber'] as String,
          hasFavCategories: extra['hasFavCategories'] as bool,
        );
      },
    ),
    GoRoute(
      path: RoutePaths.category,
      builder: (context, state) => const CategoryScreen(),
    ),

    //! Home
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const MainScreen(),
    ),

    //! Book list
    GoRoute(
      path: RoutePaths.bookList,
      name: 'books',
      builder: (context, state) {
        final title = state.uri.queryParameters['title'] ?? 'لیست کتاب‌ها';
        final type = state.uri.queryParameters['type'] ?? '';
        final value = state.uri.queryParameters['value'] ?? '';

        return BookListScreen(title: title, type: type, param: value);
      },
    ),

    //! Search
    GoRoute(
      path: RoutePaths.search,
      builder: (context, state) => const OriginalSearchScreen(),
    ),

    //! My Library
    GoRoute(
      path: RoutePaths.myLibraryBookmarks,
      builder: (context, state) => const MyLibraryBookmarksScreen(),
    ),

    //! Profile
    GoRoute(
      path: RoutePaths.profileComments,
      builder: (context, state) => const ProfileCommentsScreen(),
    ),
    GoRoute(
      path: RoutePaths.profileTransaction,
      builder: (context, state) => const ProfileTransactionScreen(),
    ),
    GoRoute(
      path: RoutePaths.profileFavorites,
      builder: (context, state) => const ProfileFavoritesScreen(),
    ),

    //! Book
    GoRoute(
      path: RoutePaths.book,
      builder: (context, state) => BookScreen(bookId: state.extra as int),
    ),
    GoRoute(
      path: RoutePaths.audioBook,
      builder: (context, state) =>
          AudioBookScreen(childBookId: state.extra as int),
    ),
    GoRoute(
      path: RoutePaths.epubViewer,
      builder: (context, state) =>
          EpubViewerScreen(epubUrl: state.extra as String),
    ),
    GoRoute(
      path: RoutePaths.cart,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: RoutePaths.pdfViewer,
      builder: (context, state) =>
          PdfViewerScreen(fileUrl: state.extra as String),
    ),
  ],

  //! Redirect
  redirect: (context, state) {
    final isLoggedIn = SessionManager.instance.isLoggedIn();
    final currentPath =
        state.matchedLocation; //! fucking important -> MatchedLocation

    final isPublicRoute = publicRoutes.contains(currentPath);

    if (!isLoggedIn && !isPublicRoute) return '/login';
    if (isLoggedIn && currentPath == '/login') return '/';
    return null;
  },

  //! Not found
  // errorBuilder: (context, state) => const NotFoundScreen(),
);
