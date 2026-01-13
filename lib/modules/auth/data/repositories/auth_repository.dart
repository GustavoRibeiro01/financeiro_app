import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/errors/auth_failures.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<Either<AuthFailure, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, UserCredential>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> reloadUser() async {
    try {
      await _firebaseAuth.currentUser?.reload();
      return const Right(unit);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deleteUser() async {
    try {
      await _firebaseAuth.currentUser?.delete();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateProfile({String? displayName, String? photoURL}) async {
    try {
      await _firebaseAuth.currentUser?.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> reauthenticateWithCredential({
    required String email,
    required String password,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateEmail({required String newEmail}) async {
    try {
      await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updatePassword({required String newPassword}) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(newPassword);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseException(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  AuthFailure _mapFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return const WeakPasswordFailure();
      case 'email-already-in-use':
        return const EmailAlreadyInUseFailure();
      case 'invalid-email':
        return const InvalidEmailFailure();
      case 'user-disabled':
        return const UserDisabledFailure();
      case 'user-not-found':
        return const UserNotFoundFailure();
      case 'wrong-password':
        return const WrongPasswordFailure();
      case 'too-many-requests':
        return const TooManyRequestsFailure();
      case 'operation-not-allowed':
        return const OperationNotAllowedFailure();
      case 'requires-recent-login':
        return const RequiresRecentLoginFailure();
      case 'network-request-failed':
        return const NetworkFailure();
      case 'invalid-credential':
        return const InvalidCredentialFailure();
      default:
        return ServerFailure(e.message);
    }
  }
}
