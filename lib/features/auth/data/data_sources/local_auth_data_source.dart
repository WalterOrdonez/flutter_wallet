import 'dart:convert';

import 'package:bam_wallet_transfers/core/local_storage.dart';
import 'package:bam_wallet_transfers/core/utils/jwt_decoder.dart';
import 'package:bam_wallet_transfers/features/auth/data/models/login_response_model.dart';

/// Data source local para manejar la persistencia de sesión.
/// Usa SharedPreferences a través de LocalStorage para almacenar
/// tokens y datos del usuario de forma persistente.
class LocalAuthDataSource {
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _userDataKey = 'auth_user_data';

  final LocalStorage _localStorage;

  LocalAuthDataSource({LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage();

  /// Guarda la respuesta completa del login (usuario + tokens)
  Future<void> saveSession(LoginResponseModel loginResponse) async {
    await _localStorage.prefs.setString(
      _accessTokenKey,
      loginResponse.accessToken,
    );
    await _localStorage.prefs.setString(
      _refreshTokenKey,
      loginResponse.refreshToken,
    );
    await _localStorage.prefs.setString(
      _userDataKey,
      jsonEncode(loginResponse.toJson()),
    );
  }

  /// Obtiene el access token almacenado
  Future<String?> getAccessToken() async {
    return _localStorage.prefs.getString(_accessTokenKey);
  }

  /// Obtiene el refresh token almacenado
  Future<String?> getRefreshToken() async {
    return _localStorage.prefs.getString(_refreshTokenKey);
  }

  /// Obtiene los datos del usuario almacenados
  Future<LoginResponseModel?> getCachedUser() async {
    final userJson = _localStorage.prefs.getString(_userDataKey);
    if (userJson == null) {
      return null;
    }
    final Map<String, dynamic> decoded =
        jsonDecode(userJson) as Map<String, dynamic>;
    return LoginResponseModel.fromJson(decoded);
  }

  /// Verifica si hay una sesión activa (token presente y no expirado)
  Future<bool> hasActiveSession() async {
    final token = _localStorage.prefs.getString(_accessTokenKey);
    if (token == null || token.isEmpty) {
      return false;
    }

    // Valida que el token no haya expirado
    if (JwtDecoder.isExpired(token)) {
      // Token vencido, limpia la sesión
      await clearSession();
      return false;
    }

    return true;
  }

  /// Limpia todos los datos de sesión almacenados
  Future<void> clearSession() async {
    await _localStorage.prefs.remove(_accessTokenKey);
    await _localStorage.prefs.remove(_refreshTokenKey);
    await _localStorage.prefs.remove(_userDataKey);
  }
}
