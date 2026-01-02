# Flutter Modular - Guia de Uso

## 📦 Instalação

O Flutter Modular (versão 6.4.1) já está instalado e configurado no projeto.

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── app/
│   ├── app_module.dart         # Módulo principal da aplicação
│   └── app_widget.dart         # Widget raiz da aplicação
└── modules/
    └── home/
        ├── home_module.dart    # Módulo da tela inicial
        └── home_page.dart      # Página inicial
```

## 🚀 Conceitos Principais

### 1. Módulos (Modules)
Os módulos organizam sua aplicação em partes independentes. Cada módulo contém:
- **binds**: Injeção de dependências (controllers, services, repositories)
- **routes**: Definição das rotas do módulo

### 2. Rotas (Routes)
Navegação entre telas usando o sistema de rotas do Modular:
```dart
// Navegar para uma rota
Modular.to.pushNamed('/rota');

// Navegar com parâmetros
Modular.to.pushNamed('/produto/123');

// Voltar
Modular.to.pop();
```

### 3. Injeção de Dependências
Registre e consuma dependências facilmente:

```dart
// Registrando no módulo
@override
void binds(Injector i) {
  i.addSingleton(() => MeuService());
  i.add(() => MeuController());
}

// Consumindo na página
final controller = Modular.get<MeuController>();
```

## 📝 Como Criar um Novo Módulo

### Passo 1: Criar a estrutura de pastas
```
lib/modules/meu_modulo/
├── meu_modulo_module.dart
├── meu_modulo_page.dart
└── meu_modulo_controller.dart
```

### Passo 2: Criar o Module
```dart
import 'package:flutter_modular/flutter_modular.dart';
import 'meu_modulo_page.dart';
import 'meu_modulo_controller.dart';

class MeuModuloModule extends Module {
  @override
  void binds(Injector i) {
    i.add(() => MeuModuloController());
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const MeuModuloPage());
    r.child('/detalhes/:id', child: (context) => const DetalhesPage());
  }
}
```

### Passo 3: Registrar no AppModule
```dart
@override
void routes(RouteManager r) {
  r.module('/', module: HomeModule());
  r.module('/meu_modulo', module: MeuModuloModule());
}
```

## 🎯 Exemplos de Uso

### Navegação Simples
```dart
// Navegar
Modular.to.pushNamed('/meu_modulo');

// Navegar com substituição
Modular.to.pushReplacementNamed('/meu_modulo');
```

### Navegação com Parâmetros
```dart
// Enviar parâmetros na URL
Modular.to.pushNamed('/produto/123');

// Receber na página
final id = Modular.args.params['id'];

// Enviar argumentos
Modular.to.pushNamed('/produto', arguments: {'nome': 'Produto X'});

// Receber
final args = Modular.args.data as Map;
```

### Injeção de Dependências
```dart
// Singleton (uma única instância)
i.addSingleton(() => ApiService());

// Lazy (criado quando necessário)
i.addLazySingleton(() => DatabaseService());

// Factory (nova instância toda vez)
i.add(() => MeuController());

// Com bind personalizado
i.addInstance(ConfigService());
```

### Consumir Dependências
```dart
// Método 1: Modular.get
final service = Modular.get<MeuService>();

// Método 2: Em widgets StatefulWidget
class MinhaPage extends StatefulWidget {
  @override
  State<MinhaPage> createState() => _MinhaPageState();
}

class _MinhaPageState extends State<MinhaPage> {
  final controller = Modular.get<MeuController>();
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

## 🔧 Recursos Avançados

### Guards (Proteção de Rotas)
```dart
class AuthGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final isAuthenticated = await checkAuth();
    if (!isAuthenticated) {
      Modular.to.pushReplacementNamed('/login');
      return false;
    }
    return true;
  }
}

// Usar no módulo
r.child('/', 
  child: (context) => HomePage(),
  guards: [AuthGuard()],
);
```

### Transições Personalizadas
```dart
r.child('/',
  child: (context) => HomePage(),
  transition: TransitionType.fadeIn,
  duration: Duration(milliseconds: 300),
);
```

## 📚 Documentação Oficial

- [Flutter Modular GitHub](https://github.com/Flutterando/modular)
- [Documentação Completa](https://modular.flutterando.com.br/)

## ✅ Checklist de Configuração

- [x] Flutter Modular instalado (v6.4.1)
- [x] AppModule criado
- [x] AppWidget configurado
- [x] HomeModule de exemplo criado
- [x] Sistema de rotas funcionando
- [x] Estrutura de pastas organizada

## 🎉 Próximos Passos

1. Criar módulos para diferentes funcionalidades (Auth, Dashboard, Transações, etc.)
2. Implementar serviços e repositories
3. Configurar gerenciamento de estado (Provider, BLoC, MobX, etc.)
4. Adicionar guards para proteção de rotas
5. Implementar navegação bottom navigation ou drawer
