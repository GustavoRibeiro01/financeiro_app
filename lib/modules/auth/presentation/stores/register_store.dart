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

    final result = await _signUpUseCase(
      email: emailController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    return result.fold(
      (failure) {
        isLoading = false;
        errorMessage = failure.message;
        return false;
      },
      (credential) {
        isLoading = false;
        emailVerificationSent = true;
        successMessage = 'Conta criada com sucesso! Verifique seu email.';
        return true;
      },
    );
  }

  @action
  Future<void> resendEmailVerification() async {
    isLoading = true;
    errorMessage = null;
    successMessage = null;

    final result = await _sendEmailVerificationUseCase();

    result.fold(
      (failure) {
        isLoading = false;
        errorMessage = failure.message;
      },
      (_) {
        isLoading = false;
        successMessage = 'Email de verificação reenviado!';
      },
    );
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
}
