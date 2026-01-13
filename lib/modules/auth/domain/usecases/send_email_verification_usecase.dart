import 'package:dartz/dartz.dart';
import '../repositories/i_auth_repository.dart';
import '../errors/auth_failures.dart';

class SendEmailVerificationUseCase {
  final IAuthRepository _repository;

  SendEmailVerificationUseCase(this._repository);

  Future<Either<AuthFailure, Unit>> call() async {
    return await _repository.sendEmailVerification();
  }
}
