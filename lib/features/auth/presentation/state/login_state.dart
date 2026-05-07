import 'package:bam_wallet_transfers/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// Representa los posibles estados de la pantalla de login
enum LoginStatus { initial, loading, success, error }

/// Estado inmutable del login generado con Freezed.
/// Contiene toda la información necesaria para renderizar la UI.
@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    User? user,
    String? errorMessage,
    @Default(true) bool obscurePassword,
    @Default(false) bool rememberMe,
  }) = _LoginState;
}

/// Extensión para propiedades computadas del estado
extension LoginStateX on LoginState {
  /// Indica si el login está en proceso
  bool get isLoading => status == LoginStatus.loading;
}
