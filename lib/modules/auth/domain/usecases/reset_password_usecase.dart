import '../repositories/i_auth_repository.dart';

class ResetPasswordUseCase {
  final IAuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<void> call({required String email}) async {
    await _repository.sendPasswordResetEmail(email: email);
  }
}
