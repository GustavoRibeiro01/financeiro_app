import 'package:mobx/mobx.dart';
import '../../domain/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthService _authService;

  _AuthStoreBase(this._authService) {
    // Observa mudanças no estado de autenticação
    _authService.authStateChanges.listen((User? user) {
      currentUser = user;
      isAuthenticated = user != null;
    });
  }

  @observable
  User? currentUser;

  @observable
  bool isAuthenticated = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> signIn({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUp({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Enviar email de verificação automaticamente
      await _authService.sendEmailVerification();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _authService.signOut();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> resetPassword({required String email}) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _authService.sendPasswordResetEmail(email: email);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> sendEmailVerification() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _authService.sendEmailVerification();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }
}
