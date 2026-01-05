import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../auth/presentation/stores/auth_store.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Modular.get<AuthStore>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perfil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Observer(
                builder: (_) => Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFF2196F3),
                      child: Text(
                        authStore.currentUser?.email
                                ?.substring(0, 1)
                                .toUpperCase() ??
                            'U',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email do usuário
                    Text(
                      authStore.currentUser?.email ?? 'Sem email',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Status de verificação
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: authStore.currentUser?.emailVerified == true
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            authStore.currentUser?.emailVerified == true
                                ? Icons.verified
                                : Icons.warning,
                            size: 16,
                            color: authStore.currentUser?.emailVerified == true
                                ? Colors.green
                                : Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            authStore.currentUser?.emailVerified == true
                                ? 'Email verificado'
                                : 'Email não verificado',
                            style: TextStyle(
                              color:
                                  authStore.currentUser?.emailVerified == true
                                  ? Colors.green
                                  : Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Lista de opções
                    Card(
                      color: const Color(0xFF252B3B),
                      child: Column(
                        children: [
                          if (authStore.currentUser?.emailVerified == false)
                            ListTile(
                              leading: const Icon(
                                Icons.email,
                                color: Colors.orange,
                              ),
                              title: const Text(
                                'Enviar email de verificação',
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: Colors.white54,
                              ),
                              onTap: () async {
                                await authStore.sendEmailVerification();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Email de verificação enviado!',
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: const Text(
                              'Sair',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Colors.white54,
                            ),
                            onTap: () async {
                              await authStore.signOut();
                              if (context.mounted) {
                                Modular.to.navigate('/auth/');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
