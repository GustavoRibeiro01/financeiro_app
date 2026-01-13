import 'package:dartz/dartz.dart';
import '../repositories/i_auth_repository.dart';
import '../errors/auth_failures.dart';

class ResetPasswordUseCase {
  final IAuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<AuthFailure, Unit>> call({required String email}) async {
    // Validações de domínio
    if (email.isEmpty) {
      return const Left(EmptyEmailFailure());
    }
    
    if (!_isValidEmail(email)) {
      return const Left(InvalidEmailFailure());
    }

    return await _repository.sendPasswordResetEmail(email: email);
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
