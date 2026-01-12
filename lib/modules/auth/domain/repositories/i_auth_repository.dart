import 'package:firebase_auth/firebase_auth.dart';

/// Interface do repositório de autenticação
abstract class IAuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> reloadUser();
  Future<void> deleteUser();
  Future<void> updateProfile({String? displayName, String? photoURL});
  Future<void> reauthenticateWithCredential({
    required String email,
    required String password,
  });
  Future<void> updateEmail({required String newEmail});
  Future<void> updatePassword({required String newPassword});
}
