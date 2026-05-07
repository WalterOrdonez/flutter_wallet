import 'package:bam_wallet_transfers/core/extensions/context_extension.dart';
import 'package:bam_wallet_transfers/core/presentation/theme/app_colors.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/login_notifier.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/login_state.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/utils/auth_error_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Vista de login que permite al usuario autenticarse
/// con su username y contraseña contra la API de DummyJSON.
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Maneja el evento de presionar el botón de login
  void _onSignInPressed() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar(context.l10n.loginEmptyFieldsError);
      return;
    }

    ref.read(loginNotifierProvider.notifier).login(username, password);
  }

  /// Muestra un SnackBar con el mensaje proporcionado
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);

    // Escucha cambios de estado para mostrar errores localizados
    ref.listen<LoginState>(loginNotifierProvider, (previous, next) {
      if (next.status == LoginStatus.error && next.errorMessage != null) {
        final localizedMessage = AuthErrorMapper.resolve(
          next.errorMessage!,
          context.l10n,
        );
        _showSnackBar(localizedMessage);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Header
                Center(
                  child: Text(
                    context.l10n.loginWelcomeBack,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGeneral,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    context.l10n.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Campo de username
                Text(
                  context.l10n.loginUsernameLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: context.l10n.loginUsernameHint,
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: AppColors.divider,
                    ),
                    filled: true,
                    fillColor: AppColors.textSecondary.withValues(alpha: 0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Campo de contraseña
                Text(
                  context.l10n.loginPasswordLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: loginState.obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onSignInPressed(),
                  decoration: InputDecoration(
                    hintText: context.l10n.loginPasswordHint,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.divider,
                    ),
                    filled: true,
                    fillColor: AppColors.textSecondary.withValues(alpha: 0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginState.obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.divider,
                      ),
                      onPressed: () {
                        ref
                            .read(loginNotifierProvider.notifier)
                            .togglePasswordVisibility();
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Recordarme y Olvidé contraseña
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: loginState.rememberMe,
                            activeColor: AppColors.textGeneral,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: const BorderSide(color: AppColors.divider),
                            onChanged: (value) {
                              ref
                                  .read(loginNotifierProvider.notifier)
                                  .toggleRememberMe(value ?? false);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.loginRememberMe,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navegar a recuperar contraseña
                      },
                      child: Text(
                        context.l10n.loginForgotPassword,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGeneral,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Botón de login
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: loginState.isLoading ? null : _onSignInPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrincipal,
                      foregroundColor: AppColors.textGeneral,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: loginState.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            context.l10n.loginSignInButton,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
