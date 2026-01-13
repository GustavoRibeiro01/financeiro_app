/// Classe abstrata base para falhas de autenticação
abstract class AuthFailure {
  final String message;
  
  const AuthFailure(this.message);
  
  @override
  String toString() => message;
}

// ===== Falhas de Validação (Domínio) =====

class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure() : super('Email inválido');
}

class InvalidPasswordFailure extends AuthFailure {
  const InvalidPasswordFailure() : super('Senha deve ter no mínimo 6 caracteres');
}

class EmptyEmailFailure extends AuthFailure {
  const EmptyEmailFailure() : super('Email não pode estar vazio');
}

class EmptyPasswordFailure extends AuthFailure {
  const EmptyPasswordFailure() : super('Senha não pode estar vazia');
}

class PasswordsDoNotMatchFailure extends AuthFailure {
  const PasswordsDoNotMatchFailure() : super('As senhas não coincidem');
}

// ===== Falhas de Autenticação (Infraestrutura) =====

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure() : super('A senha é muito fraca');
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure() : super('Este email já está em uso');
}

class UserDisabledFailure extends AuthFailure {
  const UserDisabledFailure() : super('Este usuário foi desabilitado');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure() : super('Usuário não encontrado');
}

class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure() : super('Senha incorreta');
}

class TooManyRequestsFailure extends AuthFailure {
  const TooManyRequestsFailure() : super('Muitas tentativas. Tente novamente mais tarde');
}

class OperationNotAllowedFailure extends AuthFailure {
  const OperationNotAllowedFailure() : super('Operação não permitida');
}

class RequiresRecentLoginFailure extends AuthFailure {
  const RequiresRecentLoginFailure() : super('Esta operação requer autenticação recente');
}

// ===== Falhas de Rede e Servidor =====

class NetworkFailure extends AuthFailure {
  const NetworkFailure() : super('Sem conexão com a internet');
}

class ServerFailure extends AuthFailure {
  const ServerFailure([String? message]) 
      : super(message ?? 'Erro no servidor. Tente novamente mais tarde');
}

// ===== Falha Genérica =====

class UnexpectedFailure extends AuthFailure {
  const UnexpectedFailure([String? message]) 
      : super(message ?? 'Erro inesperado. Tente novamente');
}
