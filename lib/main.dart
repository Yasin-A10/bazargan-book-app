import 'package:bazargan/config/router/app_router.dart';
import 'package:bazargan/config/theme/app_theme.dart';
import 'package:bazargan/core/blocs/all_books.dart/bloc/all_books_bloc.dart';
import 'package:bazargan/core/blocs/audio/audio_bloc.dart';
import 'package:bazargan/core/network/session_manager.dart';
import 'package:bazargan/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:bazargan/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:bazargan/features/auth/presentation/bloc/sms/sms_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/book/book_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/book_commet/book_comment_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/feedback/feedback_bloc.dart';
import 'package:bazargan/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/marked_books_bloc.dart';
import 'package:bazargan/features/profile/presentation/bloc/user_bloc.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/user_comment_bloc.dart';
import 'package:bazargan/features/profile_favorites/presentation/bloc/favorite_bloc.dart';
import 'package:bazargan/features/profile_transaction/presentation/bloc/transaction_bloc.dart';
import 'package:bazargan/features/search/presentation/bloc/search_bloc.dart';
import 'package:bazargan/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* for dependency injection
  await setup();

  //* for shared_preferences
  await SessionManager.instance.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<SmsBloc>()),
        BlocProvider(create: (_) => locator<LoginBloc>()),
        BlocProvider(create: (_) => locator<LogoutBloc>()),
        BlocProvider(create: (_) => locator<HomeBloc>()),
        BlocProvider(create: (_) => locator<SearchBloc>()),
        BlocProvider(create: (_) => locator<AllBooksBloc>()),
        BlocProvider(create: (_) => locator<UserBloc>()),
        BlocProvider(create: (_) => locator<FavoriteBloc>()),
        BlocProvider(create: (_) => locator<TransactionBloc>()),
        BlocProvider(create: (_) => locator<MarkedBooksBloc>()),
        BlocProvider(create: (_) => locator<BookBloc>()),
        BlocProvider(create: (_) => locator<BookCommentBloc>()),
        BlocProvider(create: (_) => locator<FeedbackBloc>()),
        BlocProvider(create: (_) => locator<AddToCartBloc>()),
        BlocProvider(create: (_) => locator<CartBloc>()),
        BlocProvider(create: (_) => locator<UserCommentBloc>()),
        BlocProvider(create: (_) => locator<AudioBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        locale: Locale('fa', 'IR'),
        supportedLocales: const [Locale('fa', 'IR'), Locale('en', 'US')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
