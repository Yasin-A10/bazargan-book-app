import 'package:dartz/dartz.dart';
import 'package:bazargan/features/auth/data/source/sms_sender_api_provider.dart';

class SmsSenderRepositoryImpl {
  final SmsSenderApiProvider apiProvider;

  SmsSenderRepositoryImpl({required this.apiProvider});

  Future<Either<String, dynamic>> sendSms(String phoneNumber) async {
    try {
      final result = await apiProvider.sendSms(phoneNumber);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
