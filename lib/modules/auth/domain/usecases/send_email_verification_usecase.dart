import '../repositories/i_auth_repository.dart';

class SendEmailVerificationUseCase {
  final IAuthRepository _repository;

  SendEmailVerificationUseCase(this._repository);

  Future<void> call() async {
    await _repository.sendEmailVerification();
  }
}
