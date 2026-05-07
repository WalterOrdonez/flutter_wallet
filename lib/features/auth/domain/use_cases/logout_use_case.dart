import 'package:bam_wallet_transfers/features/auth/data/repositories/authentication_repository_imp.dart';
import 'package:bam_wallet_transfers/features/auth/domain/repositories/authentication_repository.dart';

/// Caso de uso para cerrar sesión.
/// Limpia los datos de sesión del usuario actual.
class LogoutUseCase {
  final AuthenticationRepository _repository;

  LogoutUseCase({AuthenticationRepository? repository})
    : _repository = repository ?? AuthenticationRepositoryImp();

  /// Ejecuta el caso de uso de logout.
  /// Cierra la sesión y limpia los datos almacenados localmente.
  Future<void> call() async {
    await _repository.signOut();
  }
}
