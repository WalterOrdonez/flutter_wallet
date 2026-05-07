import 'package:bam_wallet_transfers/features/auth/data/repositories/authentication_repository_imp.dart';
import 'package:bam_wallet_transfers/features/auth/domain/repositories/authentication_repository.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier global que maneja el estado de autenticación de la app.
/// Verifica si hay sesión activa y permite cerrar sesión.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository _repository;

  AuthNotifier({AuthenticationRepository? repository})
    : _repository = repository ?? AuthenticationRepositoryImp(),
      super(const AuthState());

  /// Verifica si el usuario tiene una sesión activa.
  /// Se llama al iniciar la app para decidir la pantalla inicial.
  Future<void> checkAuthStatus() async {
    final isSignedIn = await _repository.isSignedIn();

    if (isSignedIn) {
      final user = await _repository.getCurrentUser();
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  /// Marca al usuario como autenticado después de un login exitoso
  void setAuthenticated(dynamic user) {
    state = AuthState(status: AuthStatus.authenticated, user: user);
  }

  /// Cierra la sesión y marca al usuario como no autenticado
  Future<void> signOut() async {
    await _repository.signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

/// Provider global del estado de autenticación.
/// Al crearse, verifica automáticamente si hay sesión activa.
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final notifier = AuthNotifier();
  notifier.checkAuthStatus();
  return notifier;
});
