import 'package:bazargan/features/auth/data/repository/sms_sender_repository_impl.dart';
import 'package:bazargan/features/auth/data/source/sms_sender_api_provider.dart';
import 'package:bazargan/features/auth/presentation/bloc/sms/sms_bloc.dart';
import 'package:bazargan/features/home/data/repository/home_repository_impl.dart';
import 'package:bazargan/features/home/data/source/home_api_provider.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  //! for api client
  // locator.registerSingleton<AuthApiClient>(AuthApiClient());

  //! API Providers
  locator.registerSingleton<SmsSenderApiProvider>(SmsSenderApiProvider());
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider());

  //! Repository
  locator.registerSingleton<SmsSenderRepositoryImpl>(
    SmsSenderRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<HomeRepositoryImpl>(
    HomeRepositoryImpl(apiProvider: locator()),
  );

  //! Bloc
  locator.registerSingleton<SmsBloc>(SmsBloc(repository: locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(repository: locator()));
}
