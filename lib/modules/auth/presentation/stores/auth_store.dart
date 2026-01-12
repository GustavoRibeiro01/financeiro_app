import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/reload_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/send_email_verification_usecase.dart';

part 'auth_store.g.dart';

/// Store principal do módulo de autenticação
/// Responsável por gerenciar o estado global de autenticação
class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final IAuthRepository _repository;
  final SignOutUseCase _signOutUseCase;
  final ReloadUserUseCase _reloadUserUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  final SendEmailVerificationUseCase _sendEmailVerificationUseCase;

  _AuthStoreBase(
    this._repository,
    this._signOutUseCase,
    this._reloadUserUseCase,
    this._deleteUserUseCase,
    this._sendEmailVerificationUseCase,
  ) {
    // Observa mudanças no estado de autenticação
    _repository.authStateChanges.listen((User? user) {
      currentUser = user;
      isAuthenticated = user != null;
      isEmailVerified = user?.emailVerified ?? false;
    });
  }

  @observable
  User? currentUser;

  @observable
  bool isAuthenticated = false;

  @observable
  bool isEmailVerified = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  // Ações principais de autenticação
  @action
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _signOutUseCase();
    } catch (e) {
      errorMessage = 'Erro ao fazer logout: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> reloadUser() async {
    try {
      await _reloadUserUseCase();
      final user = _repository.currentUser;
      currentUser = user;
      isEmailVerified = user?.emailVerified ?? false;
    } catch (e) {
      errorMessage = 'Erro ao recarregar usuário: ${e.toString()}';
    }
  }

  @action
  Future<void> deleteAccount() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _deleteUserUseCase();
    } catch (e) {
      errorMessage = 'Erro ao deletar conta: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> sendEmailVerification() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _sendEmailVerificationUseCase();
      await reloadUser();
    } catch (e) {
      errorMessage = 'Erro ao enviar email de verificação: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  // Computed values
  @computed
  String? get userEmail => currentUser?.email;

  @computed
  String? get userId => currentUser?.uid;

  @computed
  String? get userName => currentUser?.displayName;

  @computed
  bool get needsEmailVerification => isAuthenticated && !isEmailVerified;
}
