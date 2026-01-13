import 'package:dartz/dartz.dart';
import '../repositories/i_auth_repository.dart';
import '../errors/auth_failures.dart';

class SignOutUseCase {
  final IAuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<AuthFailure, Unit>> call() async {
    return await _repository.signOut();
  }
}
