import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/i_auth_repository.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/send_email_verification_usecase.dart';
import 'domain/usecases/reload_user_usecase.dart';
import 'domain/usecases/delete_user_usecase.dart';
import 'presentation/stores/auth_store.dart';
import 'presentation/stores/login_store.dart';
import 'presentation/stores/register_store.dart';
import 'presentation/stores/forgot_password_store.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/pages/forgot_password_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // Firebase Auth
    i.addInstance<FirebaseAuth>(FirebaseAuth.instance);

    // Repository
    i.add<IAuthRepository>(AuthRepository.new);

    // UseCases
    i.add(SignInUseCase.new);
    i.add(SignUpUseCase.new);
    i.add(SignOutUseCase.new);
    i.add(ResetPasswordUseCase.new);
    i.add(SendEmailVerificationUseCase.new);
    i.add(ReloadUserUseCase.new);
    i.add(DeleteUserUseCase.new);

    // Store principal do módulo (Singleton - compartilhada globalmente)
    i.addSingleton<AuthStore>(AuthStore.new);

    // Stores específicas de cada página (Lazy Singleton - criadas sob demanda)
    i.addSingleton<LoginStore>(
      LoginStore.new,
    );

    i.addSingleton<RegisterStore>(
      RegisterStore.new,
    );

    i.addSingleton<ForgotPasswordStore>(
      ForgotPasswordStore.new,
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const RegisterPage());
    r.child('/forgot-password', child: (context) => const ForgotPasswordPage());
  }
}
