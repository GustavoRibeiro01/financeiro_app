import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/i_auth_repository.dart';
import '../errors/auth_failures.dart';

class SignInUseCase {
  final IAuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<AuthFailure, UserCredential>> call({
    required String email,
    required String password,
  }) async {
    // Validações de domínio
    if (email.isEmpty) {
      return const Left(EmptyEmailFailure());
    }
    
    if (!_isValidEmail(email)) {
      return const Left(InvalidEmailFailure());
    }
    
    if (password.isEmpty) {
      return const Left(EmptyPasswordFailure());
    }
    
    if (password.length < 6) {
      return const Left(InvalidPasswordFailure());
    }

    // Chama o repository
    return await _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
