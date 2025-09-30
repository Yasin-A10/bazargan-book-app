import 'package:bazargan/features/auth/data/source/login_api_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:bazargan/core/network/session_manager.dart';
import 'package:bazargan/features/auth/data/model/login_model.dart';

class LoginRepositoryImpl {
  final LoginApiProvider apiProvider;

  LoginRepositoryImpl({required this.apiProvider});

  Future<Either<String, LoginModel>> loginWithOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final LoginModel response = await apiProvider.loginWithOtp(
        phone: phone,
        code: code,
      );

      await SessionManager.instance.saveSession(
        accessToken: response.access,
        refreshToken: response.refresh,
        role: response.role,
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
