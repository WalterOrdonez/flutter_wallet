import 'package:bam_wallet_transfers/features/auth/data/repositories/authentication_repository_imp.dart';
import 'package:bam_wallet_transfers/features/auth/domain/entities/user.dart';
import 'package:bam_wallet_transfers/features/auth/domain/repositories/authentication_repository.dart';

/// Caso de uso para iniciar sesión.
/// Encapsula la lógica de negocio del login validando
/// los datos antes de delegar al repositorio.
class LoginUseCase {
  final AuthenticationRepository _repository;

  LoginUseCase({AuthenticationRepository? repository})
    : _repository = repository ?? AuthenticationRepositoryImp();

  /// Ejecuta el caso de uso de login.
  /// [username] - Nombre de usuario
  /// [password] - Contraseña del usuario
  /// Retorna el [User] autenticado o lanza una excepción
  Future<User> call(String username, String password) async {
    // Validaciones de negocio
    if (username.isEmpty) {
      throw Exception('El nombre de usuario es requerido');
    }

    if (password.isEmpty) {
      throw Exception('La contraseña es requerida');
    }

    if (password.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    final user = await _repository.login(
      username: username,
      password: password,
    );
    return user;
  }
}
