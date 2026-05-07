import 'package:bam_wallet_transfers/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// Representa el estado global de autenticación de la app
enum AuthStatus {
  /// Estado inicial, aún no se ha verificado la sesión
  unknown,

  /// El usuario está autenticado
  authenticated,

  /// El usuario no está autenticado
  unauthenticated,
}

/// Estado global de autenticación
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    User? user,
  }) = _AuthState;
}
