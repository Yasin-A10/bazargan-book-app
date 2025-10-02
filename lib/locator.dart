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
import 'package:bazargan/features/home/data/repository/home_repository_impl.dart';
import 'package:bazargan/features/home/data/source/home_api_provider.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:bazargan/features/profile/data/repository/user_repository_impl.dart';
import 'package:bazargan/features/profile/data/repository/update_name_repository_impl.dart';
import 'package:bazargan/features/profile/data/source/user_api_provider.dart';
import 'package:bazargan/features/profile/data/source/update_name_api_provider.dart';
import 'package:bazargan/features/profile/presentation/bloc/user_bloc.dart';
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
  locator.registerSingleton<UserApiProvider>(UserApiProvider());
  locator.registerSingleton<UpdateNameApiProvider>(UpdateNameApiProvider());
  locator.registerSingleton<FavoriteCategoryApiProvider>(
    FavoriteCategoryApiProvider(),
  );
  locator.registerSingleton<AddFavoriteApiProvider>(AddFavoriteApiProvider());
  locator.registerSingleton<UserTransactionApiProvider>(
    UserTransactionApiProvider(),
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

  //! Bloc
  locator.registerSingleton<SmsBloc>(SmsBloc(repository: locator()));
  locator.registerSingleton<LoginBloc>(LoginBloc(repository: locator()));
  locator.registerSingleton<LogoutBloc>(LogoutBloc(repository: locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(repository: locator()));
  locator.registerSingleton<SearchBloc>(SearchBloc(repository: locator()));
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
}
