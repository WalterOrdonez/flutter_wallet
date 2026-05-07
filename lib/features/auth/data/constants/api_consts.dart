/// Constantes para el consumo de la API de autenticación
class AuthApiConsts {
  AuthApiConsts._();

  /// URL base de la API de DummyJSON
  static const String baseUrl = 'https://dummyjson.com';

  /// Endpoint de login
  static const String loginPath = '/auth/login';

  /// Tiempo de expiración del token en minutos
  static const int tokenExpiresInMins = 1;
}
