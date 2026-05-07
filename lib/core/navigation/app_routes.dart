/// Clase abstracta que define las rutas de la aplicación como constantes.
/// Centraliza los paths para evitar strings sueltos en el código.
abstract class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String transfers = '/transfers';
  static const String history = '/history';
  static const String settings = '/settings';
}
