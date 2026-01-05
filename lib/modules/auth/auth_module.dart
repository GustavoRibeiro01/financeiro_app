import 'package:flutter_modular/flutter_modular.dart';
import 'domain/services/auth_service.dart';
import 'presentation/stores/auth_store.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/pages/forgot_password_page.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AuthService>(AuthService.new);
    i.addSingleton<AuthStore>(() => AuthStore(i.get<AuthService>()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const RegisterPage());
    r.child('/forgot-password', child: (context) => const ForgotPasswordPage());
  }
}
