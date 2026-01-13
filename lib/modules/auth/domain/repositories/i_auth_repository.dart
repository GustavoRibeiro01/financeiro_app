import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../errors/auth_failures.dart';

/// Interface do repositório de autenticação
abstract class IAuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  
  Future<Either<AuthFailure, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<Either<AuthFailure, UserCredential>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<Either<AuthFailure, Unit>> sendEmailVerification();
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({required String email});
  Future<Either<AuthFailure, Unit>> signOut();
  Future<Either<AuthFailure, Unit>> reloadUser();
  Future<Either<AuthFailure, Unit>> deleteUser();
  Future<Either<AuthFailure, Unit>> updateProfile({String? displayName, String? photoURL});
  Future<Either<AuthFailure, Unit>> reauthenticateWithCredential({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> updateEmail({required String newEmail});
  Future<Either<AuthFailure, Unit>> updatePassword({required String newPassword});
}
