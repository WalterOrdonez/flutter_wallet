import 'dart:convert';

/// Utilidad para decodificar y validar tokens JWT.
/// No verifica la firma (eso lo hace el servidor),
/// solo extrae el payload para leer campos como `exp`.
class JwtDecoder {
  JwtDecoder._();

  /// Decodifica el payload de un token JWT y retorna el mapa de claims.
  /// Retorna null si el token es inválido o no se puede decodificar.
  static Map<String, dynamic>? decode(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = _decodeBase64(parts[1]);
      return jsonDecode(payload) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Verifica si un token JWT ya expiró basándose en el claim `exp`.
  /// Retorna true si el token está vencido o no se puede decodificar.
  static bool isExpired(String token) {
    final payload = decode(token);
    if (payload == null || !payload.containsKey('exp')) {
      return true;
    }

    final exp = payload['exp'] as int;
    final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expirationDate);
  }

  /// Obtiene la fecha de expiración del token.
  /// Retorna null si no se puede decodificar.
  static DateTime? getExpirationDate(String token) {
    final payload = decode(token);
    if (payload == null || !payload.containsKey('exp')) {
      return null;
    }

    final exp = payload['exp'] as int;
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  /// Decodifica un string base64url (usado en JWT)
  static String _decodeBase64(String input) {
    // Agrega padding si es necesario
    String normalized = input.replaceAll('-', '+').replaceAll('_', '/');
    switch (normalized.length % 4) {
      case 0:
        break;
      case 2:
        normalized += '==';
        break;
      case 3:
        normalized += '=';
        break;
      default:
        throw const FormatException('Invalid base64 string');
    }
    return utf8.decode(base64.decode(normalized));
  }
}
