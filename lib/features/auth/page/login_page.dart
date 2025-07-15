import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tokyo/core/utils/tokyo_utils.dart';
import 'package:tokyo/features/auth/controller/login_controller.dart';
import 'package:tokyo/features/theme/theme_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final themeController = GetIt.I.get<ThemeController>();
  final tokyoUtils = GetIt.I.get<TokyoUtils>();
  Future<void> _handleLogin(BuildContext context) async {
    controller.isLoading.value = true;

    //senha é Teste123@ para o user 123.456.789-09

    try {
      final cpf = controller.cpfController.text.trim();

      final password = controller.passwordController.text.trim();

      final user = await controller.loginWithCpfAndPassword(cpf, password);

      if (user != null) {
        context.replace('/home'); // usando go_router
      } else {
        _showError(context, 'Falha desconhecida no login');
      }
    } catch (e) {
      _showError(context, e.toString().replaceAll('Exception: ', ''));
    } finally {
      controller.isLoading.value = false;
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.loadSavedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (context, value, child) {
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (_, __) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    TextField(
                                      controller: controller.cpfController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        tokyoUtils.cpfMaskFormatter,
                                      ],
                                      decoration: const InputDecoration(
                                        labelText: 'CPF',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: controller.showPassword,
                                      builder: (context, show, _) {
                                        return TextField(
                                          controller:
                                              controller.passwordController,
                                          obscureText: !show,
                                          decoration: InputDecoration(
                                            labelText: 'Senha',
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                show
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                controller.showPassword.value =
                                                    !show;
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: controller.rememberMe,
                                          onChanged:
                                              (_) =>
                                                  controller.toggleRememberMe(),
                                        ),
                                        const Text('Lembrar sempre'),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            // Esqueceu a senha?
                                          },
                                          child: const Text(
                                            'Esqueceu a senha?',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: controller.isFormValid,
                                      builder: (context, isValid, _) {
                                        return SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed:
                                                isValid
                                                    ? () => _handleLogin(
                                                      buildContext,
                                                    )
                                                    : null,
                                            child: const Text('Entrar'),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // Cadastrar
                                        },
                                        child: const Text('Cadastrar'),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.facebook),
                                        SizedBox(width: 16),
                                        Icon(Icons.g_mobiledata),
                                        SizedBox(width: 16),
                                        Icon(Icons.apple),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: themeController.themeMode,
                        builder: (context, value, child) {
                          return Positioned(
                            top: 16,
                            right: 16,
                            child: IconButton(
                              icon: Icon(
                                themeController.themeMode.value ==
                                        ThemeMode.dark
                                    ? Icons.wb_sunny
                                    : Icons.nightlight_round,
                              ),
                              tooltip: 'Alternar tema',
                              onPressed: () {
                                themeController.toggleTheme();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
        },
      ),
    );
  }
}
