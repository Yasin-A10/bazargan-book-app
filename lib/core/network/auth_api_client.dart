import 'package:bazargan/config/router/app_router.dart';
import 'package:bazargan/config/router/route_paths.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bazargan/core/network/session_manager.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient._internal(this._dio);

  factory AuthApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.bazargan.app',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = SessionManager.instance.access;
          if (token != null) {
            options.headers['Authorization'] = 'NMT $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refresh = SessionManager.instance.refresh;
            if (refresh != null) {
              try {
                final newTokens = await _refreshToken(refresh);
                await SessionManager.instance.saveSession(
                  access: newTokens['access'],
                  refresh: newTokens['refresh'],
                  role: newTokens['role'],
                );

                final newRequest = error.requestOptions;
                newRequest.headers['Authorization'] =
                    'NMT ${newTokens['access']}';
                final cloneReq = await dio.fetch(newRequest);
                return handler.resolve(cloneReq);
              } catch (e) {
                await SessionManager.instance.clearSession();

                GoRouter.of(navigatorKey.currentContext!).go(RoutePaths.login);

                return handler.reject(
                  DioException(
                    requestOptions: error.requestOptions,
                    message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
                  ),
                );
              }
            } else {
              await SessionManager.instance.clearSession();
              GoRouter.of(navigatorKey.currentContext!).go(RoutePaths.login);

              return handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  message: 'نشست شما منقضی شده است. لطفاً دوباره وارد شوید.',
                ),
              );
            }
          }

          return handler.next(error);
        },
      ),
    );

    return AuthApiClient._internal(dio);
  }

  //! for refresh token
  static Future<Map<String, dynamic>> _refreshToken(String refresh) async {
    final dio = Dio();
    final response = await dio.post(
      'https://api.bazargan.app/auth/refresh-token/',
      data: {'refresh': refresh},
      options: Options(headers: {'Accept': 'application/json'}),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('رفرش توکن ناموفق بود');
    }
  }

  //! for http methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }
}
