import 'package:bam_wallet_transfers/features/auth/data/constants/auth_error_consts.dart';
import 'package:bam_wallet_transfers/l10n/app_localizations.dart';

/// Mapea las constantes de error de autenticación a mensajes localizados.
class AuthErrorMapper {
  AuthErrorMapper._();

  /// Resuelve una key de error a su texto localizado.
  /// Si la key no coincide con ninguna constante, retorna el mensaje tal cual.
  static String resolve(String errorKey, AppLocalizations l10n) {
    switch (errorKey) {
      case AuthErrorConsts.badRequest:
        return l10n.authErrorBadRequest;
      case AuthErrorConsts.unauthorized:
        return l10n.authErrorUnauthorized;
      case AuthErrorConsts.notFound:
        return l10n.authErrorNotFound;
      case AuthErrorConsts.serverError:
        return l10n.authErrorServerError;
      case AuthErrorConsts.noInternet:
        return l10n.authErrorNoInternet;
      case AuthErrorConsts.unknown:
        return l10n.authErrorUnknown;
      default:
        return errorKey;
    }
  }
}
