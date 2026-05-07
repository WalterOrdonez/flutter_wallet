/// Constantes de mensajes de error para autenticación.
/// Los valores corresponden a las keys de localización (ARB).
class AuthErrorConsts {
  AuthErrorConsts._();

  /// Error 400 - Solicitud inválida
  static const String badRequest = 'authErrorBadRequest';

  /// Error 401 - Credenciales incorrectas
  static const String unauthorized = 'authErrorUnauthorized';

  /// Error 404 - Servicio no encontrado
  static const String notFound = 'authErrorNotFound';

  /// Error 500 - Error interno del servidor
  static const String serverError = 'authErrorServerError';

  /// Sin conexión a internet
  static const String noInternet = 'authErrorNoInternet';

  /// Error desconocido
  static const String unknown = 'authErrorUnknown';
}
