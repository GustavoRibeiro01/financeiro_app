import '../repositories/i_auth_repository.dart';

class ReloadUserUseCase {
  final IAuthRepository _repository;

  ReloadUserUseCase(this._repository);

  Future<void> call() async {
    await _repository.reloadUser();
  }
}
