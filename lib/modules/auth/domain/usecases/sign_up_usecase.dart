import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/i_auth_repository.dart';
import '../errors/auth_failures.dart';

class SignUpUseCase {
  final IAuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<AuthFailure, UserCredential>> call({
    required String email,
    required String password,
    String? confirmPassword,
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
    
    if (confirmPassword != null && password != confirmPassword) {
      return const Left(PasswordsDoNotMatchFailure());
    }

    // Cria o usuário
    final credentialResult = await _repository.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Se falhou ao criar, retorna o erro
    return credentialResult.fold(
      (failure) => Left(failure),
      (credential) async {
        // Enviar email de verificação automaticamente
        await _repository.sendEmailVerification();
        return Right(credential);
      },
    );
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
