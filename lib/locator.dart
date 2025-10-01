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

  //! Bloc
  locator.registerSingleton<SmsBloc>(SmsBloc(repository: locator()));
  locator.registerSingleton<LoginBloc>(LoginBloc(repository: locator()));
  locator.registerSingleton<LogoutBloc>(LogoutBloc(repository: locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(repository: locator()));
  locator.registerSingleton<SearchBloc>(SearchBloc(repository: locator()));
}
