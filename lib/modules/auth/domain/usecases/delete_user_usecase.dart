import 'package:dartz/dartz.dart';
import '../repositories/i_auth_repository.dart';
import '../errors/auth_failures.dart';

class DeleteUserUseCase {
  final IAuthRepository _repository;

  DeleteUserUseCase(this._repository);

  Future<Either<AuthFailure, Unit>> call() async {
    return await _repository.deleteUser();
  }
}
