import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../domain/usecases/reset_password_usecase.dart';

part 'forgot_password_store.g.dart';

class ForgotPasswordStore = _ForgotPasswordStoreBase with _$ForgotPasswordStore;

abstract class _ForgotPasswordStoreBase with Store {
  final ResetPasswordUseCase _resetPasswordUseCase;

  _ForgotPasswordStoreBase(this._resetPasswordUseCase);

  // Controller
  final emailController = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  bool emailSent = false;

  @action
  Future<bool> resetPassword() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;

    try {
      await _resetPasswordUseCase(email: emailController.text.trim());
      emailSent = true;
      successMessage = 'Email de recuperação enviado com sucesso!';
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

  @action
  void reset() {
    isLoading = false;
    errorMessage = null;
    successMessage = null;
    emailSent = false;
  }

  void dispose() {
    emailController.dispose();
  }

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('user-not-found')) {
      return 'Usuário não encontrado';
    } else if (errorString.contains('invalid-email')) {
      return 'Email inválido';
    } else if (errorString.contains('too-many-requests')) {
      return 'Muitas tentativas. Tente novamente mais tarde';
    } else {
      return 'Erro ao enviar email: $errorString';
    }
  }
}
