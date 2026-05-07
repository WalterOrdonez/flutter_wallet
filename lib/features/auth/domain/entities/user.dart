import 'package:bam_wallet_transfers/features/auth/data/models/login_response_model.dart';

/// Entidad de dominio que representa al usuario autenticado
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  /// Nombre completo del usuario
  String get fullName => '$firstName $lastName';

  /// Crea una entidad User a partir del modelo de respuesta del login
  factory User.fromLoginResponse(LoginResponseModel response) {
    return User(
      id: response.id,
      username: response.username,
      email: response.email,
      firstName: response.firstName,
      lastName: response.lastName,
      gender: response.gender,
      image: response.image,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }
}
