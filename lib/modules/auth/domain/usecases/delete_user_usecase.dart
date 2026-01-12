import '../repositories/i_auth_repository.dart';

class DeleteUserUseCase {
  final IAuthRepository _repository;

  DeleteUserUseCase(this._repository);

  Future<void> call() async {
    await _repository.deleteUser();
  }
}
