import 'package:bam_wallet_transfers/features/auth/domain/entities/user.dart';

/// Contrato abstracto del repositorio de autenticación.
/// Define las operaciones disponibles para la capa de dominio.
abstract class AuthenticationRepository {
  /// Inicia sesión con username y contraseña
  Future<User> login({required String username, required String password});

  /// Cierra la sesión del usuario actual
  Future<void> signOut();

  /// Verifica si hay un usuario con sesión activa
  Future<bool> isSignedIn();

  /// Obtiene el usuario actualmente autenticado (si existe)
  Future<User?> getCurrentUser();
}
