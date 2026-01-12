import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/send_email_verification_usecase.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final SignUpUseCase _signUpUseCase;
  final SendEmailVerificationUseCase _sendEmailVerificationUseCase;

  _RegisterStoreBase(this._signUpUseCase, this._sendEmailVerificationUseCase);

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @observable
  bool emailVerificationSent = false;

  @observable
  bool obscurePassword = true;

  @observable
  bool obscureConfirmPassword = true;

  @action
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  @action
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
  }

  @action
  Future<bool> signUp() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    emailVerificationSent = false;

    try {
      await _signUpUseCase(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      emailVerificationSent = true;
      successMessage = 'Conta criada com sucesso! Verifique seu email.';
      return true;
    } catch (e) {
      errorMessage = _getErrorMessage(e);
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> resendEmailVerification() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;

    try {
      await _sendEmailVerificationUseCase();
      successMessage = 'Email de verificação reenviado!';
    } catch (e) {
      errorMessage = _getErrorMessage(e);
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
    confirmPasswordController.dispose();
  }

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('email-already-in-use')) {
      return 'Este email já está em uso';
    } else if (errorString.contains('invalid-email')) {
      return 'Email inválido';
    } else if (errorString.contains('weak-password')) {
      return 'Senha muito fraca. Use pelo menos 6 caracteres';
    } else if (errorString.contains('operation-not-allowed')) {
      return 'Operação não permitida';
    } else {
      return 'Erro ao criar conta: $errorString';
    }
  }
}
