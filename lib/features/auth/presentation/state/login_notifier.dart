import 'package:bam_wallet_transfers/features/auth/domain/use_cases/login_use_case.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/auth_notifier.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que maneja la lógica de estado del login.
/// Expone métodos para interactuar con la UI y delega
/// la lógica de negocio al LoginUseCase.
class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  final Ref _ref;

  LoginNotifier(this._ref, {LoginUseCase? loginUseCase})
    : _loginUseCase = loginUseCase ?? LoginUseCase(),
      super(const LoginState());

  /// Ejecuta el proceso de login con las credenciales proporcionadas
  Future<void> login(String username, String password) async {
    state = state.copyWith(status: LoginStatus.loading, errorMessage: null);

    try {
      final user = await _loginUseCase.call(username, password);
      state = state.copyWith(status: LoginStatus.success, user: user);

      // Actualiza el estado global de autenticación
      _ref.read(authNotifierProvider.notifier).setAuthenticated(user);
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      state = state.copyWith(status: LoginStatus.error, errorMessage: message);
    }
  }

  /// Alterna la visibilidad de la contraseña
  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  /// Actualiza el estado de "recordarme"
  void toggleRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
  }

  /// Resetea el estado a su valor inicial
  void reset() {
    state = const LoginState();
  }
}

/// Provider del LoginNotifier para inyectar en la UI
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>((
  ref,
) {
  return LoginNotifier(ref);
});
