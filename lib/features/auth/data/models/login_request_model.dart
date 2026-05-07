/// Modelo del body de solicitud para el endpoint de login.
/// Encapsula username, password y tiempo de expiración del token.
class LoginRequestModel {
  final String username;
  final String password;
  final int expiresInMins;

  LoginRequestModel({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  /// Convierte el modelo a un mapa JSON para enviar al servidor
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'expiresInMins': expiresInMins,
    };
  }
}
