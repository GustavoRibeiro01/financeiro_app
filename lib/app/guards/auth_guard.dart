import 'package:flutter_modular/flutter_modular.dart';
import '../../modules/auth/presentation/stores/auth_store.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ParallelRoute route) async {
    final authStore = Modular.get<AuthStore>();

    if (!authStore.isAuthenticated) {
      // Se não estiver autenticado, redireciona para login
      Modular.to.navigate('/auth/');
      return false;
    }

    return true;
  }
}
