import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/i_auth_repository.dart';

class SignUpUseCase {
  final IAuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<UserCredential> call({
    required String email,
    required String password,
  }) async {
    final credential = await _repository.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Enviar email de verificação automaticamente
    await _repository.sendEmailVerification();
    
    return credential;
  }
}
