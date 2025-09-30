import 'package:bazargan/features/home/data/repository/home_repository_impl.dart';
import 'package:bazargan/features/home/data/source/home_api_provider.dart';
import 'package:bazargan/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  //* for api client
  // locator.registerSingleton<AuthApiClient>(AuthApiClient());

  //* API Providers
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider());

  //* Repository
  locator.registerSingleton<HomeRepositoryImpl>(
    HomeRepositoryImpl(apiProvider: locator()),
  );

  //* Bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(repository: locator()));
}
