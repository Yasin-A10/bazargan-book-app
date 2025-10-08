import 'package:bazargan/core/api/all_books.dart/bloc/all_books_bloc.dart';
import 'package:bazargan/core/api/all_books.dart/data/repository/all_books_repository_impl.dart';
import 'package:bazargan/core/api/all_books.dart/data/source/all_books_api_provider.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/auth/data/repository/login_repository_impl.dart';
import 'package:bazargan/features/auth/data/repository/logout_repository_impl.dart';
import 'package:bazargan/features/auth/data/repository/sms_sender_repository_impl.dart';
import 'package:bazargan/features/auth/data/source/login_api_provider.dart';
import 'package:bazargan/features/auth/data/source/logout_api_provider.dart';
import 'package:bazargan/features/auth/data/source/sms_sender_api_provider.dart';
import 'package:bazargan/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:bazargan/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:bazargan/features/auth/presentation/bloc/sms/sms_bloc.dart';
import 'package:bazargan/features/book/data/repository/add_comment_repository_impl.dart';
import 'package:bazargan/features/book/data/repository/add_to_cart_repository_impl.dart';
import 'package:bazargan/features/book/data/repository/book_commnet_repository_impl.dart';
import 'package:bazargan/features/book/data/repository/book_repository_impl.dart';
import 'package:bazargan/features/book/data/repository/feedback_repository_impl.dart';
import 'package:bazargan/features/book/data/source/add_comment_api_provider.dart';
import 'package:bazargan/features/book/data/source/add_to_cart_api_provider.dart';
import 'package:bazargan/features/book/data/source/book_api_provider.dart';
import 'package:bazargan/features/book/data/source/book_comment_api_provider.dart';
import 'package:bazargan/features/book/data/source/feedback_api_provider.dart';
import 'package:bazargan/features/book/presentation/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/book/book_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/book_commet/book_comment_bloc.dart';
import 'package:bazargan/features/book/presentation/bloc/feedback/feedback_bloc.dart';
import 'package:bazargan/features/cart/data/repository/cart_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/delete_cart_repository_impl.dart';
import 'package:bazargan/features/cart/data/source/cart_api_provider.dart';
import 'package:bazargan/features/cart/data/source/delete_cart_api_provider.dart';
import 'package:bazargan/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:bazargan/features/home/data/repository/home_repository_impl.dart';
import 'package:bazargan/features/home/data/source/home_api_provider.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:bazargan/features/my_library_bookmarks/data/repository/add_bookmark_repository_impl.dart';
import 'package:bazargan/features/my_library_bookmarks/data/repository/marked_books_repository_impl.dart';
import 'package:bazargan/features/my_library_bookmarks/data/source/add_bookmark_api_provider.dart';
import 'package:bazargan/features/my_library_bookmarks/data/source/marked_books_api_provider.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/marked_books_bloc.dart';
import 'package:bazargan/features/profile/data/repository/user_repository_impl.dart';
import 'package:bazargan/features/profile/data/repository/update_name_repository_impl.dart';
import 'package:bazargan/features/profile/data/source/user_api_provider.dart';
import 'package:bazargan/features/profile/data/source/update_name_api_provider.dart';
import 'package:bazargan/features/profile/presentation/bloc/user_bloc.dart';
import 'package:bazargan/features/profile_comments/data/repository/delete_comment_repository_impl.dart';
import 'package:bazargan/features/profile_comments/data/repository/update_comment_repository_impl.dart';
import 'package:bazargan/features/profile_comments/data/repository/user_comment_repository_impl.dart';
import 'package:bazargan/features/profile_comments/data/source/delete_comment_api_provider.dart';
import 'package:bazargan/features/profile_comments/data/source/update_comment_api_provider.dart';
import 'package:bazargan/features/profile_comments/data/source/user_comment_api_provider.dart';
import 'package:bazargan/features/profile_comments/presentation/bloc/user_comment_bloc.dart';
import 'package:bazargan/features/profile_favorites/data/repository/add_favorite_repository_impl.dart';
import 'package:bazargan/features/profile_favorites/data/repository/favorite_category_repository_impl.dart';
import 'package:bazargan/features/profile_favorites/data/source/add_favorite_api_provider.dart';
import 'package:bazargan/features/profile_favorites/data/source/favorite_category_api_provider.dart';
import 'package:bazargan/features/profile_favorites/presentation/bloc/favorite_bloc.dart';
import 'package:bazargan/features/profile_transaction/data/repository/user_transaction_repository_impl.dart';
import 'package:bazargan/features/profile_transaction/data/source/user_transaction_api_providr.dart';
import 'package:bazargan/features/profile_transaction/presentation/bloc/transaction_bloc.dart';
import 'package:bazargan/features/search/data/repository/search_repository_impl.dart';
import 'package:bazargan/features/search/data/source/search_api_provider.dart';
import 'package:bazargan/features/search/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  //! for api client
  locator.registerSingleton<AuthApiClient>(AuthApiClient());

  //! API Providers
  locator.registerSingleton<SmsSenderApiProvider>(SmsSenderApiProvider());
  locator.registerSingleton<LoginApiProvider>(LoginApiProvider());
  locator.registerSingleton<LogoutApiProvider>(LogoutApiProvider());
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider());
  locator.registerSingleton<SearchApiProvider>(SearchApiProvider());
  locator.registerSingleton<AllBooksApiProvider>(AllBooksApiProvider());
  locator.registerSingleton<UserApiProvider>(UserApiProvider());
  locator.registerSingleton<UpdateNameApiProvider>(UpdateNameApiProvider());
  locator.registerSingleton<FavoriteCategoryApiProvider>(
    FavoriteCategoryApiProvider(),
  );
  locator.registerSingleton<AddFavoriteApiProvider>(AddFavoriteApiProvider());
  locator.registerSingleton<UserTransactionApiProvider>(
    UserTransactionApiProvider(),
  );
  locator.registerSingleton<MarkedBooksApiProvider>(MarkedBooksApiProvider());
  locator.registerSingleton<AddBookmarkApiProvider>(AddBookmarkApiProvider());
  locator.registerSingleton<BookApiProvider>(BookApiProvider());
  locator.registerSingleton<BookCommentApiProvider>(BookCommentApiProvider());
  locator.registerSingleton<FeedbackApiProvider>(FeedbackApiProvider());
  locator.registerSingleton<AddCommentApiProvider>(AddCommentApiProvider());
  locator.registerSingleton<AddToCartApiProvider>(AddToCartApiProvider());
  locator.registerSingleton<CartApiProvider>(CartApiProvider());
  locator.registerSingleton<DeleteCartApiProvider>(DeleteCartApiProvider());
  locator.registerSingleton<UserCommentApiProvider>(UserCommentApiProvider());
  locator.registerSingleton<UpdateCommentApiProvider>(
    UpdateCommentApiProvider(),
  );
  locator.registerSingleton<DeleteCommentApiProvider>(
    DeleteCommentApiProvider(),
  );

  //! Repository
  locator.registerSingleton<SmsSenderRepositoryImpl>(
    SmsSenderRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<LoginRepositoryImpl>(
    LoginRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<LogoutRepositoryImpl>(
    LogoutRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<HomeRepositoryImpl>(
    HomeRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<SearchRepositoryImpl>(
    SearchRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<AllBooksRepositoryImpl>(
    AllBooksRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UserRepositoryImpl>(
    UserRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UpdateNameRepositoryImpl>(
    UpdateNameRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<FavoriteCategoryRepositoryImpl>(
    FavoriteCategoryRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<AddFavoriteRepositoryImpl>(
    AddFavoriteRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UserTransactionRepositoryImpl>(
    UserTransactionRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<MarkedBooksRepositoryImpl>(
    MarkedBooksRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<AddBookmarkRepositoryImpl>(
    AddBookmarkRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<BookRepositoryImpl>(
    BookRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<BookCommentsRepositoryImpl>(
    BookCommentsRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<FeedbackRepositoryImpl>(
    FeedbackRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<AddCommentRepositoryImpl>(
    AddCommentRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<AddToCartRepositoryImpl>(
    AddToCartRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<CartRepositoryImpl>(
    CartRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<DeleteCartRepositoryImpl>(
    DeleteCartRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UserCommentRepositoryImpl>(
    UserCommentRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UpdateCommentRepositoryImpl>(
    UpdateCommentRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<DeleteCommentRepositoryImpl>(
    DeleteCommentRepositoryImpl(apiProvider: locator()),
  );

  //! Bloc
  locator.registerSingleton<SmsBloc>(SmsBloc(repository: locator()));
  locator.registerSingleton<LoginBloc>(LoginBloc(repository: locator()));
  locator.registerSingleton<LogoutBloc>(LogoutBloc(repository: locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(repository: locator()));
  locator.registerSingleton<SearchBloc>(SearchBloc(repository: locator()));
  locator.registerSingleton<AllBooksBloc>(AllBooksBloc(repository: locator()));
  locator.registerSingleton<UserBloc>(
    UserBloc(userRepository: locator(), updateNameRepository: locator()),
  );
  locator.registerSingleton<FavoriteBloc>(
    FavoriteBloc(
      favoriteCategoryRepository: locator(),
      addFavoriteRepository: locator(),
    ),
  );
  locator.registerSingleton<TransactionBloc>(
    TransactionBloc(repository: locator()),
  );
  locator.registerSingleton<MarkedBooksBloc>(
    MarkedBooksBloc(
      markedBooksRepository: locator(),
      addBookmarkRepository: locator(),
    ),
  );
  locator.registerSingleton<BookBloc>(BookBloc(bookRepository: locator()));
  locator.registerSingleton<BookCommentBloc>(
    BookCommentBloc(
      bookCommentsRepository: locator(),
      addCommentRepository: locator(),
    ),
  );
  locator.registerSingleton<FeedbackBloc>(
    FeedbackBloc(feedbackRepository: locator()),
  );
  locator.registerSingleton<AddToCartBloc>(
    AddToCartBloc(addToCartRepository: locator()),
  );
  locator.registerSingleton<CartBloc>(
    CartBloc(cartRepository: locator(), deleteCartRepository: locator()),
  );
  locator.registerSingleton<UserCommentBloc>(
    UserCommentBloc(
      userCommentRepository: locator(),
      updateCommentRepository: locator(),
      deleteCommentRepository: locator(),
    ),
  );
}
