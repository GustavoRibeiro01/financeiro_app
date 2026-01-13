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

    final result = await _signInUseCase(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    return result.fold(
      (failure) {
        isLoading = false;
        errorMessage = failure.message;
        return false;
      },
      (credential) {
        isLoading = false;
        successMessage = 'Login realizado com sucesso!';
        return true;
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
  }
}
