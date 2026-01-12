import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../domain/usecases/sign_in_usecase.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final SignInUseCase _signInUseCase;

  _LoginStoreBase(this._signInUseCase);

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  bool obscurePassword = true;

  @action
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  @action
  Future<bool> signIn() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;

    try {
      await _signInUseCase(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      successMessage = 'Login realizado com sucesso!';
      return true;
    } catch (e) {
      errorMessage = _getErrorMessage(e);
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('user-not-found')) {
      return 'Usuário não encontrado';
    } else if (errorString.contains('wrong-password')) {
      return 'Senha incorreta';
    } else if (errorString.contains('invalid-email')) {
      return 'Email inválido';
    } else if (errorString.contains('user-disabled')) {
      return 'Usuário desabilitado';
    } else if (errorString.contains('too-many-requests')) {
      return 'Muitas tentativas. Tente novamente mais tarde';
    } else {
      return 'Erro ao fazer login: $errorString';
    }
  }
}
